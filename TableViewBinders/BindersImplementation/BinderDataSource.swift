//
//  BinderDataSource.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit
import Combine

typealias CellInstanceData = (cell: UITableViewCell, indexPath: IndexPath)

typealias ScrollingData = (direction: BinderDataSource.ScrollingDirection, contentOffset: CGPoint, contentSise: CGSize)

final class BinderDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    enum ScrollingDirection {
        case up, down
    }
    
    private var previousDataList: [BinderModel] = []
    private var dataList: [BinderModel] = []
    private var pendingDataList: [BinderModel] = []
    private var bindersDictionary: [String : String] = [:]
    private var cellsIndexPaths = [IndexPath : BinderCell]()
    private var cellCount = 0
    private var successDif = true
    private (set) var cellSubject = PassthroughSubject<CellInstanceData, Never>()
    private (set) var deleteCellSubject = PassthroughSubject<IndexPath, Never>()
    private (set) var cellSelectSubject = PassthroughSubject<CellInstanceData, Never>()
    private (set) var scrollingSubject = PassthroughSubject<ScrollingData, Never>()
    
    init(with binders: [BinderCell]) {
        super.init()
        binders.forEach { cell in
            bindersDictionary[cell.getType()] = cell.cellNibName()
        }
    }
    
    func registerNibs() -> (UITableView) -> Void  {
        return { [weak self]  tableView in
            self?.bindersDictionary.forEach { key, cell in
                tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: key)
            }
        }
    }
    
    func setPendingData()-> ([BinderModel]) -> Void {
        return { [weak self]  list in
            guard let self = self else { return }
            self.pendingDataList = list
        }
    }
    
    func submitPendingUpdate(_ animation: UITableView.RowAnimation = .none, _ skipReloadIndexPaths: [IndexPath]? = []) -> (UITableView) -> (Void) {
        return { [weak self]  tableView in
            guard let self = self else { return }
            (self.pendingDataList, tableView) |> self.submitList(animation)
        }
    }
    
    func submitList(_ animation: UITableView.RowAnimation = .none, _ skipReloadIndexPaths: [IndexPath]? = []) -> ([BinderModel], UITableView) -> Void {
        return { [weak self]  list, tableView in
            guard let self = self else { return }
            self.dataList = list
            self.pendingDataList = []
            tableView |> self.loadDifferencesWith(animation, skipReloadIndexPaths)
        }
    }
    
    func loadDifferencesWith(_ animation: UITableView.RowAnimation = .none,_ skipReloadIndexPaths: [IndexPath]? = []) -> (UITableView) -> Void {
        return { [weak self] tableView in
            guard let self = self else { return }
            guard self.cellCount != 0 && self.dataList.count != 0 else {
                self.cellCount = self.dataList.count
                self.previousDataList = self.dataList
                tableView.reloadData()
                return
            }
            (self.dataList, self.previousDataList, tableView) |> self.handleDiffs(animation, skipReloadIndexPaths)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard dataList.count > indexPath.row else { return 0 }
        return dataList[indexPath.row].rowHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  (tableView, indexPath) |> computeCell() else { return UITableViewCell() }
        cell.setup(with: self.dataList[indexPath.row])
        cellSubject.send((cell, indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cellSelectSubject.send((cell, indexPath))
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard self.dataList.count > indexPath.row else { return false }
        return self.dataList[indexPath.row].isEditable()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            guard let cell = self.cellsIndexPaths[indexPath] else { return }
            cell.delete()
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
        var scrollingDirection = ScrollingDirection.down
        if translation.y > 0 {
            scrollingDirection = .up
        }
        scrollingSubject.send((scrollingDirection, scrollView.contentOffset, scrollView.contentSize))
    }
    
    // MARK:  Private Methods
    
    private func computeCell() -> (UITableView, IndexPath) -> BinderCell? {
        return { [weak self] tableView, indexPath in
            guard let self = self else { return nil }
            guard indexPath.row < self.dataList.count else { return nil }
            let binderType = "\(type(of: self.dataList[indexPath.row]))"
            let cell = tableView.dequeueReusableCell(withIdentifier: binderType, for: indexPath) as! BinderCell
            self.cellsIndexPaths[indexPath] = cell
            return cell
        }
    }
    
    private func handleDiffs(_ animation: UITableView.RowAnimation = .none,_ skipReloadIndexPaths: [IndexPath]? = []) -> ([BinderModel], [BinderModel], UITableView) -> Void {
        return { [weak self] dataList, previousDataList, tableView in
            guard let self = self else { return }
            DispatchQueue.global(qos: .userInteractive).sync {
                let differences = dataList.difference(from: previousDataList)
                
                var inserts = [Int]()
                var removals = [Int]()
                differences.forEach { change in
                    switch change {
                    case .insert(let offset, _, _):
                        inserts.append(offset)
                    case .remove(let offset, _, _):
                        removals.append(offset)
                    }
                }
                self.successDif = true
                tableView.performBatchUpdates({ [weak self] in
                    guard let self = self else { return }
                    let supportAnimation = (animation != .none)
                    UIView.setAnimationsEnabled(supportAnimation)
                    
                    //Delete operation
                    if removals.count > 0 {
                        let indexPaths = removals.map{ IndexPath(row: $0, section: 0) }
                        if (dataList.count == previousDataList.count) {
                            let updateIndexPaths = indexPaths.filter({ (skipReloadIndexPaths ?? []).contains($0) != true })
                            tableView.reloadRows(at: updateIndexPaths, with: .none)
                        } else {
                            guard !indexPaths.contains(where: { $0.row > tableView.numberOfRows(inSection: 0) - 1}) else {
                                self.resetDataList()
                                self.successDif = false
                                safeAssert()
                                //Here is our case where the delete is out of bounds
                                return
                            }
                            self.cellCount -= removals.count
                            tableView.deleteRows(at: indexPaths, with: animation)
                            indexPaths.forEach { self.deleteCellSubject.send($0)}
                        }
                    }
                    //
                    
                    //Insert operation
                    if inserts.count > 0 {
                        let indexPaths = inserts.map { IndexPath(row: $0, section: 0) }
                        if (dataList.count == previousDataList.count) {
                            let updateIndexPaths = indexPaths.filter({ (skipReloadIndexPaths ?? []).contains($0) != true })
                            tableView.reloadRows(at: updateIndexPaths, with: .none)
                        } else {
                            guard !indexPaths.contains(where: { $0.row > self.cellCount + inserts.count}) else {
                                self.resetDataList()
                                self.successDif = false
                                safeAssert()
                                //Here is our case where the insert is out of bounds
                                return
                            }
                            self.cellCount += inserts.count
                            tableView.insertRows(at: indexPaths, with: animation)
                        }
                    }
                    self.cellCount = self.dataList.count
                    self.previousDataList = self.dataList
                }){ [weak self] finished  in
                    guard let self = self else { return }
                    guard finished else {
                        self.successDif = true
                        self.resetDataList()
                        tableView.reloadData()
                        UIView.setAnimationsEnabled(true)
                        safeAssert()
                        return
                    }
                    guard self.successDif else {
                        self.successDif = true
                        tableView.reloadData()
                        UIView.setAnimationsEnabled(true)
                        return
                    }
                    guard dataList.count != previousDataList.count else {
                        UIView.setAnimationsEnabled(true)
                        return
                    }
                    let indexPaths = tableView.indexPathsForVisibleRows ?? []
                    let updateIndexPaths = indexPaths.filter({ (skipReloadIndexPaths ?? []).contains($0) != true })
                    tableView.reloadRows(at: updateIndexPaths, with: .none)
                    UIView.setAnimationsEnabled(true)
                }
            }
        }
        //
    }
    
    private func resetDataList() {
        self.cellCount = self.dataList.count
        self.previousDataList = self.dataList
    }
}

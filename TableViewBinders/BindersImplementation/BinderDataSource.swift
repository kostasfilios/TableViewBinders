//
//  BinderDataSource.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit


final class BinderDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var dataList: [BinderModelConformer] = []
    private var binders: [BinderCellType] = []
    
    init(with binders: [BinderCellType]) {
        super.init()
        self.binders = binders
    }
    
    func registerNibs() -> (UITableView) -> Void  {
        return { tableView in
            self.binders.forEach { cellType in
                tableView.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.identifier)
            }
        }
    }
    
    func setData() -> ([BinderModel]) -> Void {
        return { list in
            self.dataList = list
        }
    }
    
    func submit() -> ([BinderModelConformer], UITableView) -> Void {
        return { list, tableView in
            self.dataList = list
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataList[indexPath.row].rowHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView, indexPath) |> computeCell()
        cell.setup(with: self.dataList[indexPath.row])
        return cell
    }
    
    // MARK:  Private Methods

    private func computeCell() -> (UITableView, IndexPath) -> BinderCell {
        return { tableView, indexPath in
            let cellIdentifier = self.dataList[indexPath.row].getCellType().identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BinderCell
            return cell
        }
    }
    
}

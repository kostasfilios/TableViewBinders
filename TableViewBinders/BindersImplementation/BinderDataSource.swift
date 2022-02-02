//
//  BinderDataSource.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit


final class BinderDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var dataList: [BinderModel] = []
    private var bindersDictionary: [String : (BinderCell)] = [:]
    
    
    init(with binders: [BinderCell]) {
        super.init()
        binders.forEach { cell in
            bindersDictionary[cell.getType()] = cell
        }
    }
    
    func registerNibs() -> (UITableView) -> Void  {
        return { tableView in
            self.bindersDictionary.forEach { key, cell in
                tableView.register(UINib(nibName: cell.cellNibName(), bundle: nil), forCellReuseIdentifier: cell.getType())
            }
        }
    }
    
    func setData() -> ([BinderModel]) -> Void {
        return { list in
            self.dataList = list
        }
    }
    
    func submit() -> ([BinderModel], UITableView) -> Void {
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
      return (tableView, indexPath) |> computCell()
    }

    private func computCell() -> (UITableView, IndexPath) -> UITableViewCell {
        return { tableView, indexPath in
            let binderModel = "\(type(of: self.dataList[indexPath.row]))"
            let cell = tableView.dequeueReusableCell(withIdentifier: binderModel, for: indexPath) as! BinderCell
            return cell
        }
    }
    
}

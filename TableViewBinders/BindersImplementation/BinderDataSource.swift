//
//  BinderDataSource.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit

final class TableViewDataSource<C: BinderCell & UITableViewCell, D: BinderModel> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var binders: [C] = []
    private var dataList: [D] = []
    private var bindersDictionary: [D : C] = [:]
    
    
    init(with binders: [C], tableView: UITableView) {
        super.init()
        self.binders = binders
        binders.forEach { cell in
            bindersDictionary[cell.binderModelData as! D] = cell
        }
    }
    
    func registerNibs() -> (UITableView) -> Void  {
        return { tableView in
            self.binders.forEach { cell in
                var cellIdentifier: String { return String("\(cell)Identifier") }
                tableView.register(UINib(nibName: String(describing: Self.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
            }
        }
    }
    
    func submit() -> ([D], UITableView) -> Void {
        return { list, tableView in
            self.dataList = list
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return indexPath |> computCell()
    }

    private func computCell() -> (IndexPath) -> UITableViewCell {
        return { indexPath in
            let binderModel = self.dataList[indexPath.row]
            guard let binderCell = self.bindersDictionary[binderModel] else { return UITableViewCell() }
            return binderCell
        }
    }
    
}

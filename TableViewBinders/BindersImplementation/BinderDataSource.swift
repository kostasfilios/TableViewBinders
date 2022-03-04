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
    
    init(with models: [BinderModelConformer]) {
        super.init()
        self.dataList = models
        self.binders = models.map{ $0.getCellType() }
    }
    
    func bind(to tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView |> registerNibs()
        tableView.reloadData()
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

    private func registerNibs() -> (UITableView) -> Void  {
        return { tableView in
            self.binders.forEach { cellType in
                tableView.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.identifier)
            }
        }
    }
    
    private func computeCell() -> (UITableView, IndexPath) -> BinderCell {
        return { tableView, indexPath in
            let cellIdentifier = self.dataList[indexPath.row].getCellType().identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BinderCell
            return cell
        }
    }
    
}

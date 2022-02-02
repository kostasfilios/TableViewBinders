//
//  BinderCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit


protocol BinderCellConformer: Hashable {
    func setup(with data: BinderModel)
    func getType() -> String
    func cellNibName() -> String
    
}

class BinderCell: UITableViewCell, BinderCellConformer {
    typealias DataType = BinderModel
    
    func setup(with data: DataType) {}
    
    func getType() -> String {
        return DataType.getType()
    }
    
    func cellNibName() -> String {
        return String(describing: Self.self)
    }
}

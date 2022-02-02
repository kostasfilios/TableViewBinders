//
//  BinderCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit


protocol BinderCellConformer: Hashable {
    func setup(with data: BinderModelConformer)
    func getType() -> String
    func cellNibName() -> String
    
}

class BinderCell: UITableViewCell, BinderCellConformer {
    typealias DataType = BinderModelConformer
    
    func setup(with data: DataType) {}
    
    func getType() -> String {
        return "You have to set it on inheritance"
    }
    
    func cellNibName() -> String {
        return String(describing: Self.self)
    }
}

//
//  BinderCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit


protocol BinderCellConformer: Hashable {
    associatedtype DataType: BinderModel
    func setup(with data: DataType)
    
}

class BinderCell: UITableViewCell, BinderCellConformer {
    func setup(with data: BinderModel) {}
    
    func getType() -> String {
        return "\(type(of: BinderModel.self).self)"
    }
    
    func cellNibName() -> String {
        return String(describing: Self.self)
    }
}

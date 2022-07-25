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
    func delete()
    var deletable: Bool { get }
}

class BinderCell: UITableViewCell, BinderCellConformer {
    typealias DataType = BinderModelConformer
    
    private var binder: DataType?
    
    var deletable: Bool {
        return false
    }
    
    var binderModel: DataType? { binder }

    func setup(with data: DataType) {
        binder = data
    }

    func getType() -> String {
        fatalError("All subclasses of BinderCell must override the getType function")
    }

    func cellNibName() -> String {
        return String(describing: Self.self)
    }
    
    func delete() {}
}

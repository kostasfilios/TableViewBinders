//
//  BinderModel.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit

protocol BinderModelConformer {
    func rowHeight() -> CGFloat
    static func getType() -> String
}

class BinderModel: NSObject, BinderModelConformer {
    func rowHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func isEditable() -> Bool {
        return false
    }
    
    static func getType() -> String {
        return String(describing: Self.self)
    }
}

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
    func getCellType() -> BinderCellType
}

extension BinderModelConformer {
    func rowHeight() -> CGFloat {
        UITableView.automaticDimension
    }
}

class BinderModel: NSObject, BinderModelConformer {
    func rowHeight() -> CGFloat {
        return 45
    }
    
    func getCellType() -> BinderCellType {
        return BinderCellType(ImageCellBinderTableViewCell.self)
    }
}

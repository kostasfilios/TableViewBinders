//
//  ImageCellBinderModel.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import Foundation
import UIKit

struct ImageCellBinderModel: BinderModelConformer {
    func getCellType() -> BinderCellType {
        BinderCellType(ImageCellBinderTableViewCell.self)
    }
}



//
//  TitleCellBinderModel.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import Foundation
import UIKit

struct TitleCellBinderModel {
    let title: String
}

extension TitleCellBinderModel: BinderModelConformer {
    func getCellType() -> BinderCellType {
        BinderCellType(TitleCellBinderTableViewCell.self)
    }
}

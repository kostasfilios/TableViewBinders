//
//  TitleCellBinderModelStruct.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 2/2/22.
//

import Foundation
import UIKit

struct TitleCellBinderModelStruct {
    let title: String
}

extension TitleCellBinderModelStruct: BinderModelConformer {
    func rowHeight() -> CGFloat {
        UITableView.automaticDimension
    }
    
    func getCellType() -> BinderCellType {
        BinderCellType(TitleCellBinderStructTableViewCell.self)
    }
}

//
//  ImageCellBinderModelStruct.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 2/2/22.
//

import Foundation
import UIKit


struct ImageCellBinderModelStruct: BinderModelConformer {
    
    func getCellType() -> BinderCellType {
        BinderCellType(ImageCellBinderStructTableViewCell.self)
    }
    
    func rowHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}

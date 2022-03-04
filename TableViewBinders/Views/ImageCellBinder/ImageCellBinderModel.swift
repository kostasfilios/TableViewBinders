//
//  ImageCellBinderModel.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import Foundation
import UIKit

final class ImageCellBinderModel: BinderModel {
    
    override func getCellType() -> BinderCellType {
        BinderCellType(ImageCellBinderTableViewCell.self)
    }
    
    override func rowHeight() -> CGFloat {
        return 40
    }
}

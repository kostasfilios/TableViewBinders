//
//  TitleCellBinderModel.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import Foundation
import UIKit

final class TitleCellBinderModel: BinderModel {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    override func getCellType() -> BinderCellType {
        BinderCellType(TitleCellBinderTableViewCell.self)
    }
    
    override func rowHeight() -> CGFloat {
        return 80
    }
    
}

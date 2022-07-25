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
    
    override func rowHeight() -> CGFloat {
        return 80
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? TitleCellBinderModel else { return  false }
        return other.title == self.title
    }
    
}

//
//  ImageCellBinderModel.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import Foundation
import UIKit

final class ImageCellBinderModel: BinderModel {
    
    let imageUrl: String?
    
    init(_ imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    override func rowHeight() -> CGFloat {
        return 200
    }
}

//
//  ImageCellBinderModelStruct.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 2/2/22.
//

import Foundation
import UIKit


struct ImageCellBinderModelStruct: BinderModelConformer {
    static func getType() -> String {
        return String(describing: Self.self)
    }
    
    
    func rowHeight() -> CGFloat {
        return 40
    }
}

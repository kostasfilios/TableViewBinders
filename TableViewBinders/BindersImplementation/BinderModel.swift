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

}

class BinderModel: NSObject, BinderModelConformer {
    func rowHeight() -> CGFloat {
        return 45
    }
}

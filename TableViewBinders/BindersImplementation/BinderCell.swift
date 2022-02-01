//
//  BinderCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit

protocol BinderCell: Hashable {
    
    associatedtype binderData: BinderModel
    
    var binderModelData: binderData { get set }
    
    func setup(with data: binderData)
    
}

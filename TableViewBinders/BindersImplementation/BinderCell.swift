//
//  BinderCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import Foundation
import UIKit

protocol BinderCell: AnyObject, Hashable {
    
    associatedtype T: BinderModel
    
    func setup(with data: T)
    
}

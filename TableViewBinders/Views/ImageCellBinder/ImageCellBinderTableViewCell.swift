//
//  ImageCellBinderTableViewCell.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import UIKit

final class ImageCellBinderTableViewCell: BinderCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
    override func getType() -> String { ImageCellBinderModel.getType() }
    
    
    override func setup(with data: BinderCell.DataType) {
        
    }
}

//
//  ImageCellBinderTableViewCell.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import UIKit

final class ImageCellBinderTableViewCell: BinderCell<ImageCellBinderModel> {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setup(with data: ImageCellBinderModel) {
        
    }
    
    override func getType() -> String {
        return String(describing: ImageCellBinderModel.self)
    }
    
}

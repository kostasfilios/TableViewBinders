//
//  ImageCellBinderStructTableViewCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 2/2/22.
//

import UIKit

class ImageCellBinderStructTableViewCell: BinderCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
    override func getType() -> String { ImageCellBinderModelStruct.getType() }
    
    
    override func setup(with data: BinderCell.DataType) {
        
    }
}

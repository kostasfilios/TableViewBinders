//
//  TitleCellBinderStructTableViewCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 2/2/22.
//

import UIKit

class TitleCellBinderStructTableViewCell: BinderCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setup(with data: BinderModel) {
        
    }
    
    override func getType() -> String { TitleCellBinderModelStruct.getType() }
}


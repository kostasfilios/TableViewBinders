//
//  TitleCellBinderTableViewCell.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import UIKit

class TitleCellBinderTableViewCell: BinderCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    

    
    
    override func setup(with data: BinderModel) {
        
    }
    
    override func getType() -> String {
        return String(describing: TitleCellBinderModel.self)
    }
}

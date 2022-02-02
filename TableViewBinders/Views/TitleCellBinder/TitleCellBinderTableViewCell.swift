//
//  TitleCellBinderTableViewCell.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import UIKit

class TitleCellBinderTableViewCell: BinderCell<TitleCellBinderModel> {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    

    
    
    override func setup(with data: TitleCellBinderModel) {
        
    }
    
    override func getType() -> String {
        return String(describing: TitleCellBinderModel.self)
    }
}

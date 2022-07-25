//
//  TitleCellBinderTableViewCell.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import UIKit

class TitleCellBinderTableViewCell: BinderCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setup(with data: BinderModelConformer) {
        guard let data = data as? TitleCellBinderModel else { return }
        titleLabel.text = data.title
    }
    
    override func getType() -> String { TitleCellBinderModel.getType() }
    
}

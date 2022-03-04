//
//  TitleCellBinderStructTableViewCell.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 2/2/22.
//

import UIKit

class TitleCellBinderStructTableViewCell: BinderCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setup(with data: BinderModelConformer) {
        guard let data = data as? TitleCellBinderModelStruct else { return }
        titleLabel.text = data.title
    }
}


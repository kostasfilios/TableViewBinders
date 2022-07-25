//
//  ImageCellBinderTableViewCell.swift
//  TableViewBinders
//
//  Created by Mobile Lead on 2/2/22.
//

import UIKit

final class ImageCellBinderTableViewCell: BinderCell {
    
    @IBOutlet private weak var nasaImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    override func getType() -> String { ImageCellBinderModel.getType() }
    
    
    override func setup(with data: BinderCell.DataType) {
        guard let model = data as? ImageCellBinderModel else { return }
        nasaImage.set(imageURL: model.imageUrl, cache: true)
    }
    
    private func reset() {
        nasaImage.image = nil
    }
}

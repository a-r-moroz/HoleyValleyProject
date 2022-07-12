//
//  FavoriteDecorationCollectionCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 12.07.22.
//

import UIKit

class FavoriteDecorationCollectionCell: UICollectionViewCell {

    @IBOutlet weak var decorationPictureView: UIImageView!
    @IBOutlet weak var decorationNameLabel: UILabel!
    @IBOutlet weak var viewWithData: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorationPictureView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.imageInContainer)
        viewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }

}

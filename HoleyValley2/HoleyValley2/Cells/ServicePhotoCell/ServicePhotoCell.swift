//
//  ServicePhotoCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 15.07.22.
//

import UIKit

class ServicePhotoCell: UICollectionViewCell {

    @IBOutlet weak var servicePhotoView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        servicePhotoView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }

}

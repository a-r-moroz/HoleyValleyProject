//
//  DecorationCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase

class DecorationCell: UITableViewCell {

    @IBOutlet weak var decorationPictureView: UIImageView!
    @IBOutlet weak var decorationNameLabel: UILabel!
    @IBOutlet weak var decorationPriceLabel: UILabel!
    @IBOutlet weak var viewWithData: UIView!
    @IBOutlet weak var previewName: UIView!
    @IBOutlet weak var previewPrice: UIView!
    
//    var database: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorationPictureView.setRounding()
        viewWithData.setRoundingToView(cornerRadius: 18)
        viewWithData.setShadowToView(color: Const.Colors.gray.cgColor, cornerRadius: 18)
        
        previewName.layer.cornerRadius = previewName.frame.height / 4
        previewPrice.layer.cornerRadius = previewPrice.frame.height / 4
        previewName.isHidden = false
        previewPrice.isHidden = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}

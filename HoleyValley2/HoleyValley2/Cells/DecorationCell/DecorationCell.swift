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
    
//    var database: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorationPictureView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.photos)
        viewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.decorationPictureView.image = UIImage(named: "imagePatternLittle")
    }
}

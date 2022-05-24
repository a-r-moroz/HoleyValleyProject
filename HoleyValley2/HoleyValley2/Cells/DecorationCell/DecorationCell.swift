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
    @IBOutlet weak var viewForShadow: UIView!
    
//    var database: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorationPictureView.setRounding()
        viewWithData.setRoundingToView(cornerRadius: 18)
        viewForShadow.setShadowToView(color: CGColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1), cornerRadius: 18)
//        setRoundingAndShadow(color: CGColor(gray: 0.5, alpha: 0.6))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}

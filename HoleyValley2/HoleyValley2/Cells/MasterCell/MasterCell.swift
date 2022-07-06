//
//  MasterCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 20.06.22.
//

import UIKit

class MasterCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var masterPhoto: UIImageView!
    @IBOutlet weak var viewWithData: UIView!
    
    var isSelectedCell = false
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        masterPhoto.setRoundingToView(cornerRadius: Const.CornerRadiusTo.imageInContainer)
        viewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
//        viewWithData.setShadowToView(color: Const.Colors.gray.cgColor, cornerRadius: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        
        self.masterPhoto.image = UIImage(systemName: "person.fill")
    }
    
}

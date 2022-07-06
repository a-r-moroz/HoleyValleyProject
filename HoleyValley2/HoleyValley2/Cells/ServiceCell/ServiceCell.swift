//
//  ServiceCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 23.05.22.
//

import UIKit

class ServiceCell: UITableViewCell {

    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var ViewWithData: UIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()

        ViewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

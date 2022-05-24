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
    @IBOutlet weak var viewForShadow: UIView!
    @IBOutlet weak var ViewWithData: UIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        viewForShadow.setShadowToView(color: CGColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1), cornerRadius: 18)
        ViewWithData.setRoundingToView(cornerRadius: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

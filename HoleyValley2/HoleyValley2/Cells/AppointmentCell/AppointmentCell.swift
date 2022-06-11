//
//  AppointmentCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 11.06.22.
//

import UIKit

class AppointmentCell: UITableViewCell {
    
    @IBOutlet weak var appointmentDate: UILabel!
    @IBOutlet weak var appointmentTime: UILabel!
    @IBOutlet weak var ViewWithData: UIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        ViewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        ViewWithData.setShadowToView(color: Const.Colors.gray.cgColor, cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

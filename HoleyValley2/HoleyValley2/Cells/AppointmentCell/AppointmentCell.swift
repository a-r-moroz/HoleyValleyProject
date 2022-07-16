//
//  AppointmentCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 11.06.22.
//

import UIKit

class AppointmentCell: UITableViewCell {
    
    @IBOutlet weak var appointmentNameLabel: UILabel!
    @IBOutlet weak var appointmentPhoneLabel: UILabel!
    @IBOutlet weak var appointmentDateLabel: UILabel!
    @IBOutlet weak var appointmentTimeLabel: UILabel!
    @IBOutlet weak var appointmentMasterNameLabel: UILabel!
    @IBOutlet weak var appointmentNotificationDateAndTimeLabel: UILabel!
    @IBOutlet weak var ViewWithData: UIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        ViewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
}

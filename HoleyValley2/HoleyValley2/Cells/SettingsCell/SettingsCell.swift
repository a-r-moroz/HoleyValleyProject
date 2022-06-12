//
//  SettingsCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 12.06.22.
//

import UIKit

class SettingsCell: UITableViewCell {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

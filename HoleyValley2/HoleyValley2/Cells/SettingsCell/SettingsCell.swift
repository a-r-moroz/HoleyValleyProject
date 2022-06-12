//
//  SettingsCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 12.06.22.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var settingNameLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    var switchAction: ((_ isOn: Bool) -> ())?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(_ type: SettingsPoints) {
        settingNameLabel.text = type.settingTitle
    }
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        switchAction?(sender.isOn)
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        switchAction = nil
    }
}

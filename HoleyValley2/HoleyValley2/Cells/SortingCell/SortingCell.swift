//
//  SortingCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 5.06.22.
//

import UIKit

class SortingCell: UITableViewCell {

    @IBOutlet weak var sortingLabel: UILabel!
    @IBOutlet weak var sortingButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    func setupCellWith(_ type: SortingPoints) {
        
        sortingLabel.text = type.sortingType
    }
    
    @IBAction func popUpButtonAction(_ sender: UIButton) {
        
    }
}

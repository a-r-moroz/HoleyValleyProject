//
//  SelectedMasterViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.07.22.
//

import UIKit

class SelectedMasterViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var masterPhoto: UIImageView!
    @IBOutlet weak var viewWithData: UIView!
    
    var master: Master?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        masterPhoto.setRounding()
        viewWithData.setRoundingToView(cornerRadius: 18)
        viewWithData.setShadowToView(color: Const.Colors.gray.cgColor, cornerRadius: 18)
        
        guard let master = master else { return }
        nameLabel.text = master.name
        experienceLabel.text = master.experience
        descriptionLabel.text = master.description
        masterPhoto.sd_setImage(with: URL(string: master.photo), placeholderImage: UIImage(systemName: "person.fill"))
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}

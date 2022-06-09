//
//  ProfileViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var nameInputField: InputField!
    @IBOutlet weak var surnameInputField: InputField!
    @IBOutlet weak var phoneInputField: InputField!
    @IBOutlet weak var viewWithData: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = "Профиль"
        viewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        nameInputField.validationType = .name
        nameInputField.textField.placeholder = "Имя"
        surnameInputField.validationType = .surname
        surnameInputField.textField.placeholder = "Фамилия"
        phoneInputField.validationType = .phone
        phoneInputField.textField.placeholder = "+375 (XX) XXX-XX-XX"
        phoneInputField.textField.keyboardType = .numberPad
//        phoneInputField.textField.delegate = self
    }

    @IBAction func editAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            
            self.nameLabel.isHidden = true
            self.phoneLabel.isHidden = true
            self.editButtonOutlet.isHidden = true
            self.viewWithData.isHidden = false
        }
    }

    @IBAction func saveAction(_ sender: UIButton) {
        
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            
            self.viewWithData.isHidden = true
            self.nameLabel.isHidden = false
            self.phoneLabel.isHidden = false
            self.editButtonOutlet.isHidden = false
        }
    }
}

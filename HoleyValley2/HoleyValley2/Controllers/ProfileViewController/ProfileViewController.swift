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
    @IBOutlet weak var oldViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var newViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var oldLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var newLabelConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = "Профиль"
        viewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        nameInputField.validationType = .name
        nameInputField.textField.placeholder = "Имя"
        nameInputField.placeholderLabel.textColor = .label
        surnameInputField.validationType = .surname
        surnameInputField.textField.placeholder = "Фамилия"
        surnameInputField.placeholderLabel.textColor = .label
        phoneInputField.validationType = .phone
        phoneInputField.textField.placeholder = "+375 (XX) XXX-XX-XX"
        phoneInputField.placeholderLabel.textColor = .label
        phoneInputField.textField.keyboardType = .numberPad
//        phoneInputField.textField.delegate = self
    }

    @IBAction func editAction(_ sender: UIButton) {
        
        self.oldViewConstraint.isActive = false
        self.oldLabelConstraint.isActive = false
        self.newViewConstraint.isActive = true
        self.newLabelConstraint.isActive = true
        
        UIView.animate(withDuration: 0.7, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseOut]) {
            
            self.view.layoutIfNeeded()
            self.viewWithData.alpha = 1
            self.nameLabel.alpha = 0
            self.phoneLabel.alpha = 0
            self.editButtonOutlet.alpha = 0

        } completion: { (finish) in
            if finish {
//                self.viewWithData.verticalShake(self.viewWithData)
                self.view.layoutIfNeeded()
            }
        }
    }

    @IBAction func saveAction(_ sender: UIButton) {
        
        if nameInputField.isValid, surnameInputField.isValid, phoneInputField.isValid {
            
            //
            
            self.oldViewConstraint.isActive = true
            self.oldLabelConstraint.isActive = true
            self.newViewConstraint.isActive = false
            self.newLabelConstraint.isActive = false
            
            UIView.animate(withDuration: 0.7, delay: 0.05) {
                
                self.view.layoutIfNeeded()
                self.viewWithData.alpha = 0
                self.nameLabel.alpha = 1
                self.phoneLabel.alpha = 1
                self.editButtonOutlet.alpha = 1
            } completion: { finish in
                if finish {
                    self.view.layoutIfNeeded()
                    self.nameInputField.textField.text = ""
                    self.surnameInputField.textField.text = ""
                    self.phoneInputField.textField.text = ""
                }
            }
        } else {
            let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
            let alert = UIAlertController(title: "Упс!", message: "Пожалуйста, удебитесь, что все поля заполнены корректно.", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        self.oldViewConstraint.isActive = true
        self.oldLabelConstraint.isActive = true
        self.newViewConstraint.isActive = false
        self.newLabelConstraint.isActive = false
        
        UIView.animate(withDuration: 0.7, delay: 0.05) {
            
            self.view.layoutIfNeeded()
            self.viewWithData.alpha = 0
            self.nameLabel.alpha = 1
            self.phoneLabel.alpha = 1
            self.editButtonOutlet.alpha = 1
        } completion: { finish in
            if finish {
                self.view.layoutIfNeeded()
                self.nameInputField.textField.text = ""
                self.surnameInputField.textField.text = ""
                self.phoneInputField.textField.text = ""
            }
        }
    }
    
    
}

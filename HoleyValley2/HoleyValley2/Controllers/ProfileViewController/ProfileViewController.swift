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
    @IBOutlet weak var favoritesButtonOutlet: UIButton!
    @IBOutlet weak var appointmentsButtonOutlet: UIButton!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    /*
    var appointments = RealmManager.read(type: Appointment.self) {
        didSet {
            appointmentsTable.reloadData()
        }
    }
    */
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = Const.tabBarItemTitles.fourthItem
        setupUI()
        setupInputFields()
        addSettingsButton()
        getAppVersion()
        phoneInputField.textField.delegate = self
        
        guard let name = UserDefaults.standard.string(forKey: "userName"),
              let surname = UserDefaults.standard.string(forKey: "userSurname"),
              let phone = UserDefaults.standard.string(forKey: "userPhone") else { return }
        nameLabel.text = name + " " + surname
        phoneLabel.text = phone
    }
    
    private func setupUI() {
        
        favoritesButtonOutlet.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        appointmentsButtonOutlet.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }
    
    private func getAppVersion() {
        
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        appVersionLabel.text = "Версия \(version)"
    }
    
    private func setupInputFields() {
        
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
    
    private func openingAnimation() {
        
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            
            self.view.layoutIfNeeded()
            self.viewWithData.alpha = 1
            self.nameLabel.alpha = 0
            self.phoneLabel.alpha = 0
            self.editButtonOutlet.alpha = 0

        } completion: { (finish) in
            if finish {
                
                self.oldViewConstraint.isActive = false
                self.oldLabelConstraint.isActive = false
                self.newViewConstraint.isActive = true
                self.newLabelConstraint.isActive = true
                
                UIView.animate(withDuration: 0.7, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseOut]) {
                    
                    self.viewWithData.alpha = 1
                    self.nameLabel.alpha = 0
                    self.phoneLabel.alpha = 0
                    self.editButtonOutlet.alpha = 0
                    self.view.layoutIfNeeded()

                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func closingAnimation() {
        
        self.oldViewConstraint.isActive = true
        self.oldLabelConstraint.isActive = true
        self.newViewConstraint.isActive = false
        self.newLabelConstraint.isActive = false
        
        UIView.animate(withDuration: 0.5, delay: 0.05) {
            
            self.view.layoutIfNeeded()

        } completion: { finish in
            if finish {
                
                UIView.animate(withDuration: 0.2, delay: 0.0) {
                    
                    self.viewWithData.alpha = 0
                    self.nameLabel.alpha = 1
                    self.phoneLabel.alpha = 1
                    self.editButtonOutlet.alpha = 1
                }
                
                self.view.layoutIfNeeded()
                self.nameInputField.textField.text = ""
                self.surnameInputField.textField.text = ""
                self.phoneInputField.textField.text = ""
            }
        }
    }
    
    private func addSettingsButton() {
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(showSortingVC(sender:)))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc func showSortingVC(sender:UIBarButtonItem) {
        
        let settingsVC = SettingsViewController(nibName: String(describing: SettingsViewController.self), bundle: nil)
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    @IBAction func editAction(_ sender: UIButton) {
        
        openingAnimation()
    }

    @IBAction func saveAction(_ sender: UIButton) {
        
        if nameInputField.isValid, surnameInputField.isValid, phoneInputField.isValid {
            
            guard let name = nameInputField.textField.text,
                  let surname = surnameInputField.textField.text,
                  let phone = phoneInputField.textField.text else { return }
            
            UserDefaults.standard.set(name, forKey: "userName")
            UserDefaults.standard.set(surname, forKey: "userSurname")
            UserDefaults.standard.set(phone, forKey: "userPhone")
            
            nameLabel.text = name + " " + surname
            phoneLabel.text = phone
            
            closingAnimation()
        } else {
            let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
            let alert = UIAlertController(title: "Упс!", message: "Пожалуйста, удебитесь, что все поля заполнены корректно.", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        closingAnimation()
    }
    
    @IBAction func favoriteDecorationsAction(_ sender: UIButton) {
        
        let FavoriteDecorationsVC = FavoriteDecorationsViewController(nibName: String(describing: FavoriteDecorationsViewController.self), bundle: nil)
        navigationController?.pushViewController(FavoriteDecorationsVC, animated: true)
    }
    
    @IBAction func appointmentsAction(_ sender: UIButton) {
        
        let appointmentsTableVC = AppointmentsTableViewController(nibName: String(describing: AppointmentsTableViewController.self), bundle: nil)
        navigationController?.pushViewController(appointmentsTableVC, animated: true)
    }
    
    @IBAction func popularQuestionsAction(_ sender: UIButton) {
        
        let questionsVC = PopularQuestionsViewController(nibName: String(describing: PopularQuestionsViewController.self), bundle: nil)
        navigationController?.pushViewController(questionsVC, animated: true)
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+XXX (XX) XXX-XX-XX", phone: newString)
        return false
    }
    
 // +X (XXX) XXX-XXXXX
    func format(with mask: String, phone: String) -> String {

        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = Const.Colors.gold.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = UIColor.systemGray5.cgColor
    }
}
 

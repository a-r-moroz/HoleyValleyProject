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
    @IBOutlet weak var appointmentsTable: UITableView!
    @IBOutlet weak var oldViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var newViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var oldLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var newLabelConstraint: NSLayoutConstraint!
    
//    var appointments = [Appointment]()
    /*
    var appointments = RealmManager.read(type: Appointment.self) {
        didSet {
            appointmentsTable.reloadData()
//            checkTableCount()
        }
    }
    */
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = "Профиль"
        setupInputFields()
        setupTable()
        addSettingsButton()
        phoneInputField.textField.delegate = self
        
        guard let name = UserDefaults.standard.string(forKey: "userName"),
              let surname = UserDefaults.standard.string(forKey: "userSurname"),
              let phone = UserDefaults.standard.string(forKey: "userPhone") else { return }
        nameLabel.text = name + " " + surname
        phoneLabel.text = phone

//        appointments = BarController.appointments
    }
    /*
    override func viewWillAppear(_ animated: Bool) {

        appointments = RealmManager.read(type: Appointment.self)
        appointmentsTable.reloadData()
//        checkTableCount()
    }
    */
    private func setupInputFields() {
        
        viewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        nameInputField.validationType = .name
        nameInputField.textField.placeholder = "Имя"
        nameInputField.placeholderLabel.textColor = .label
//        nameInputField.placeholderLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        surnameInputField.validationType = .surname
        surnameInputField.textField.placeholder = "Фамилия"
        surnameInputField.placeholderLabel.textColor = .label
//        surnameInputField.placeholderLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        phoneInputField.validationType = .phone
        phoneInputField.textField.placeholder = "+375 (XX) XXX-XX-XX"
        phoneInputField.placeholderLabel.textColor = .label
//        phoneInputField.placeholderLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        phoneInputField.textField.keyboardType = .numberPad
//        phoneInputField.textField.delegate = self
    }
    
    private func setupTable() {
        
        appointmentsTable.register(UINib(nibName: String(describing: AppointmentCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AppointmentCell.self))
//        appointmentsTable.delegate = self
//        appointmentsTable.dataSource = self
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
//                self.viewWithData.verticalShake(self.viewWithData)
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
}

/*
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appointment = appointments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentCell.self), for: indexPath)
        guard let appointmentCell = cell as? AppointmentCell else { return cell }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU")
        dateFormatter.dateFormat = "d MMM, yyyy"
        let dateString = dateFormatter.string(from: appointment.date)
        appointmentCell.appointmentDate.text = dateString
        appointmentCell.appointmentTime.text = appointment.time
        return appointmentCell
    }
    
    
}
*/

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
    
 // mask example: `+X (XXX) XXX-XXXXX
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
 

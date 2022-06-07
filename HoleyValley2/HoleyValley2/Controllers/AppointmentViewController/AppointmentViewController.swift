//
//  AppointmentViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 24.05.22.
//

import UIKit
import Firebase
import FSCalendar

class AppointmentViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var timeInputField: InputField!
    @IBOutlet weak var nameInputField: InputField!
    @IBOutlet weak var surnameInputField: InputField!
    @IBOutlet weak var phoneInputField: InputField!
    
    var database: DatabaseReference!
    var name: String?
    var surname: String?
    var openingHours = ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"]
    var selectedDate: String?
//    private lazy var availableHours: [String] = {
//
//        return allHours
//    }()
    var usingHours = [String]()
    var busyHours = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        confirmButtonOutlet.setCapsuleRoundingToButton()
        confirmButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
        infoView.setRoundingToView(cornerRadius: 18)
        infoView.setShadowToView(color: Const.Colors.gray.cgColor, cornerRadius: 18)

        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
//        hideKeyboardByTap()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.locale = Locale(identifier: "RU")
        
        database = Database.database().reference()

        timeInputField.textField.inputView = picker
        timeInputField.textField.placeholder = "12:00"
        timeInputField.validationType = .none
        nameInputField.validationType = .name
        nameInputField.textField.placeholder = "Имя"
        surnameInputField.validationType = .surname
        surnameInputField.textField.placeholder = "Фамилия"
        phoneInputField.validationType = .phone
        phoneInputField.textField.placeholder = "+375 (XX) XXX-XX-XX"
        phoneInputField.textField.keyboardType = .numberPad
        phoneInputField.textField.delegate = self
    }
    
    //Calls this function when the tap is recognized to hide keyboard
    private func hideKeyboardByTap() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func availableHours(date: String) {
        
        database = Database.database().reference().child("\(Const.Firebase.appointmentsPath)/\(date)")

        self.busyHours = []
        
        database.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.busyHours.append(key)
//                self.usingHours.filter { $0 != key }
            }

            DispatchQueue.main.async {
                self.usingHours = self.openingHours.filter { !self.busyHours.contains($0) }
                print("ARRAY BUSY:\n\(self.busyHours)")
                print("ARRAY USE:\n\(self.usingHours)")
            }
        }
}
    
    @IBAction func saveAppointmentAction(_ sender: UIButton) {
        
        if timeInputField.isValid, nameInputField.isValid, surnameInputField.isValid, phoneInputField.isValid {
            guard let name = nameInputField.textField.text,
                  let surname = surnameInputField.textField.text,
                  let time = timeInputField.textField.text,
                  let phone = phoneInputField.textField.text else { return }
                    // let date = selectedDate
            
            
            self.database.child("\(time)").setValue(["name" : surname + " " + name, "phone" : phone])
    //        self.database.child("appointments/\(date)/\(time)").setValue(["name" : surname + " " + name])
    //        self.database.child("appointments").setValue(["name": name])
            
            guard let date = selectedDate else { return }
            let action = UIAlertAction(title: "Ок", style: .default) { action in
                self.navigationController?.popViewController(animated: true) }
            let alert = UIAlertController(title: "Ура!", message: "Вы записаны на приём к мастеру на \(date) в \(time). Во вкладке Профиль можно настроить оповещения :)", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true)
            
            DispatchQueue.main.async {
                self.timeInputField.textField.text = ""
                self.nameInputField.textField.text = ""
                self.surnameInputField.textField.text = ""
                self.phoneInputField.textField.text = ""
            }
        } else {
            let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
            let alert = UIAlertController(title: "Ошибка!", message: "Не все поля заполнены или заполнены некорректно! Пожалуйста, удебитесь, что данные введены правильно.", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}

extension AppointmentViewController: UIPickerViewDelegate {
    
}

extension AppointmentViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return usingHours.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        usingHours[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeInputField.textField.text = usingHours[row]
    }
}

extension AppointmentViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "RU")
        dateFormatter.dateFormat = "d MMM, yyyy"
        let dateString = dateFormatter.string(from: date)
        selectedDate = dateString
        availableHours(date: dateString)
                
        //        for i in busyHours {
        //            usingHours = openingHours.filter { $0 != i }
        //        }
        
//        for i in openingHours {
//        for a in busyHours {
//            if i == a {
//                continue
//            } else {
//                usingHours.append(i)
//            }
//        }
//        }
        

        print(dateString)
    }
    
//    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//
//        print("deselect")
//    }
    
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        return true
//    }
}

extension AppointmentViewController: FSCalendarDataSource {

    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval((24 * 60 * 60) * 55)
    }
}


extension AppointmentViewController: UITextFieldDelegate {
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
}
 

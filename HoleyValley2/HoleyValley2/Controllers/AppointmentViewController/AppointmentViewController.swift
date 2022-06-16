//
//  AppointmentViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 24.05.22.
//

import UIKit
import Firebase
import FSCalendar
//import RealmSwift

class AppointmentViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var timeInputField: InputField!
    @IBOutlet weak var nameInputField: InputField!
    @IBOutlet weak var surnameInputField: InputField!
    @IBOutlet weak var phoneInputField: InputField!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var setNotificationButtonOutlet: UIButton!
    
    var database: DatabaseReference!
    var name: String?
    var surname: String?
    var openingHours = Const.openingHours
    var selectedDate: String?
    var dateForAlert: Date?
    var dateForNotification = Date()
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
        setNotificationButtonOutlet.setCapsuleRoundingToButton()
        setNotificationButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
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
        
        guard let name = UserDefaults.standard.string(forKey: "userName"),
              let surname = UserDefaults.standard.string(forKey: "userSurname"),
              let phone = UserDefaults.standard.string(forKey: "userPhone") else { return }
        nameInputField.textField.text = name
        surnameInputField.textField.text = surname
        phoneInputField.textField.text = phone
                
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

//            newAppointment?.time = String(Date.now.timeIntervalSince1970)
//            BarController.appointments.append(newAppointment ?? Appointment())
            
            self.database.child("\(time)").setValue(["name" : surname + " " + name, "phone" : phone])
    //        self.database.child("appointments/\(date)/\(time)").setValue(["name" : surname + " " + name])
    //        self.database.child("appointments").setValue(["name": name])
            
//            guard let date = selectedDate else { return }
            guard let date = dateForAlert else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "RU")
            dateFormatter.dateFormat = "d MMM, yyyy"
            let dateString = dateFormatter.string(from: date)
            /*
            let newAppointment = Appointment()
            newAppointment.time = time
            newAppointment.date = date
            RealmManager.add(object: newAppointment)
            */
            
//            let curDate = date.toLocalTime()
//            let notificationDate = curDate.addingTimeInterval((15 * 60 * 60) + (51 * 60))

            
            let notificationBody = "Ждём Вас сегодня в \(time)\nпо адресу: Кальварийская улица, 25, 302"
            NotificationManager.requestAutorization(body: notificationBody, time: dateForNotification)
            // 2022-06-15 11:39:26 +0000
            print("dateForNotification: \(dateForNotification)")
            
            
            let action = UIAlertAction(title: "Ок", style: .default) { action in
                self.navigationController?.popViewController(animated: true) }
            let alert = UIAlertController(title: "Ура!", message: "Вы записаны на прием к мастеру на \(dateString) в \(time). Во вкладке Профиль можно настроить оповещения :)", preferredStyle: .alert)
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
            let alert = UIAlertController(title: "Упс!", message: "Пожалуйста, удебитесь, что все поля заполнены корректно.", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @IBAction func setNotificationAppointmentAction(_ sender: UIButton) {
        
        let notificationsSettingsVC = NotificationsSettingsViewController(nibName: String(describing: NotificationsSettingsViewController.self), bundle: nil)
        notificationsSettingsVC.modalTransitionStyle = .coverVertical
        notificationsSettingsVC.modalPresentationStyle = .overFullScreen
        
        notificationsSettingsVC.postDate = {
            
            guard let notDate = notificationsSettingsVC.notificationDate else { return }
            self.dateForNotification = notDate
        }
        
        self.present(notificationsSettingsVC, animated: true)
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
        dateFormatter.locale = Locale(identifier: "EN")
        dateFormatter.dateFormat = "d MMM, yyyy"
        let dateString = dateFormatter.string(from: date)
        selectedDate = dateString
        dateForAlert = date
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
        
        
//        let curDate = dateForAlert!.toLocalTime()
//        let notificationDate = curDate.addingTimeInterval(11 * 60 * 60)
//        print(notificationDate)

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
 

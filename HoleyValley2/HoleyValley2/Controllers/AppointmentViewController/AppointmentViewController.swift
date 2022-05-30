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

    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var database: DatabaseReference!
    var name: String?
    var surname: String?
    let openingHours = ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"]
//    var selectedAppointment: Appointment?
    var selectedDate: String?

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        confirmButtonOutlet.setCapsuleRoundingToButton()
        confirmButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)

        let picker = UIPickerView()
        timeField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        
//        hideKeyboardByTap()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.locale = Locale(identifier: "RU")
        
        database = Database.database().reference()

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
    
    @IBAction func saveAppointmentAction(_ sender: UIButton) {
        
        guard let name = nameField.text, let surname = surnameField.text, let time = timeField.text, let date = selectedDate else { return }
        
        
        self.database.child("appointments/\(date)/\(time)").setValue(["name" : surname + " " + name])
//        self.database.child("appointments").setValue(["name": name])
    }
    
}

extension AppointmentViewController: UIPickerViewDelegate {
    
}

extension AppointmentViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return openingHours.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        openingHours[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeField.text = openingHours[row]
    }
}

extension AppointmentViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.dateFormat = "d MMM, yyyy"
        let dateString = dateFormatter.string(from: date)
        selectedDate = dateString
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
        return Date().addingTimeInterval((24 * 60 * 60) * 45)
    }
}

//extension AppointmentViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        textField.resignFirstResponder()
//        return true
//    }
//}

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
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    
    
    var ref: DatabaseReference!
    var name = String()
    var surname = String()
    let openingHours = ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"]

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        confirmButtonOutlet.setCapsuleRounding()
        confirmButtonOutlet.addShadow(color: CGColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1))
        calendarView.delegate = self
        calendarView.dataSource = self

        let picker = UIPickerView()
        timeField.inputView = picker
        picker.delegate = self
        picker.dataSource = self

    }
    
    @IBAction func saveAppointmentAction(_ sender: UIButton) {
        
        ref = Database.database().reference()
//        self.ref.child("appointments").setValue(["name": name])
    }
    
}

extension AppointmentViewController: FSCalendarDelegate {
    
}

extension AppointmentViewController: FSCalendarDataSource {
    
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

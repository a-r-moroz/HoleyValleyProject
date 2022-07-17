//
//  NotificationsSettingsViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 13.06.22.
//

import UIKit

class NotificationsSettingsViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var disclaimerView: UIView!
    @IBOutlet weak var warningImage: UIImageView!

    var postDate: (() -> ())?
    var notificationDate: Date?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        timePicker.locale = Locale(identifier: "ru")
        timePicker.addTarget(self, action: #selector(timePickerValue(sender:)), for: UIControl.Event.valueChanged)
    }
    
    private func setupUI() {
        
        disclaimerView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        saveButtonOutlet.setCapsuleRoundingToButton()
        saveButtonOutlet.setShadowWithOffsetToView(color: Const.Colors.gray.cgColor, cornerRadius: Const.CornerRadiusTo.viewAndImage)
        warningImage.tintColor = Const.Colors.red
    }
    
    @objc func timePickerValue(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        self.notificationDate = timePicker.date
        
//        self.selectedDate = picker.date
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM-dd-yyyy HH:mm"
//        dateField.text = formatter.string(from: picker.date)
        
        let selectedTime = dateFormatter.string(from: sender.date)
        print(selectedTime)
    }

    @IBAction func saveAction(_ sender: UIButton) {
        
        postDate?()
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}

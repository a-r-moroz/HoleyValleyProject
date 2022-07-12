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

//        viewWithData.setRoundingToView(cornerRadius: 41)
//        viewWithData.layer.cornerRadius = Const.CornerRadiusTo.viewAndImage
//        viewWithData.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        disclaimerView.setRoundingToView(cornerRadius: 18)


        saveButtonOutlet.setCapsuleRoundingToButton()
        saveButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
        warningImage.tintColor = Const.Colors.red
        
        timePicker.locale = Locale(identifier: "ru")
        
//        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValue(sender:)), for: UIControl.Event.valueChanged)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        UIView.animate(withDuration: 0.3, delay: 0.3) {
//            self.backgroundView.alpha = 1.0
//        }
//    }
    
    @objc func timePickerValue(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
//        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
            self.notificationDate = timePicker.date
        
        
//            self.selectedDate = picker.date
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MM-dd-yyyy HH:mm"
//            dateField.text = formatter.string(from: picker.date)

        
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

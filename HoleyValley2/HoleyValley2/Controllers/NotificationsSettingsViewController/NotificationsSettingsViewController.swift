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
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var viewWithData: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWithData.setRoundingToView(cornerRadius: 41)
        saveButtonOutlet.setCapsuleRoundingToButton()
        cancelButtonOutlet.setCapsuleRoundingToButton()
        
//        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValue(sender:)), for: UIControl.Event.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            self.backgroundView.alpha = 1.0
        }
    }
    
    @objc func timePickerValue(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.dateFormat = "hh:mm"
        
        let selectedTime = dateFormatter.string(from: sender.date)
        print(selectedTime)
    }

    @IBAction func saveAction(_ sender: UIButton) {
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2) {
            
            self.backgroundView.alpha = 0.0
            
        } completion: { finished in
            
            self.dismiss(animated: true)
        }
    }
}

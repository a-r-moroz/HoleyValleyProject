//
//  AppointmentViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 24.05.22.
//

import UIKit
import Firebase

class AppointmentViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    
    
    var ref: DatabaseReference!
    var name = String()
    var surname = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        
    }
    
    @IBAction func saveAppointmentAction(_ sender: UIButton) {
        
        ref = Database.database().reference()
        self.ref.child("appointments").setValue(["name": name])
    }
    
}

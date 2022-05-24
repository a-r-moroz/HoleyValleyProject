//
//  ReceptionViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit

class ReceptionViewController: UIViewController {

    @IBOutlet weak var mapWithCoordinatesView: UIView!
    @IBOutlet weak var appointmentButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appointmentButtonOutlet.setCapsuleRounding()
        appointmentButtonOutlet.addShadow(color: CGColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1))
        mapWithCoordinatesView.layer.cornerRadius = 10
    }

    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
        let appointmentVC = AppointmentViewController(nibName: String(describing: appointmentButtonOutlet.self), bundle: nil)
        
        navigationController?.pushViewController(appointmentVC, animated: true)
    }
    
}

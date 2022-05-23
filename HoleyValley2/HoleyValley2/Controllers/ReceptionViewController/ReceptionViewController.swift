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

        appointmentButtonOutlet.setRounding()
        appointmentButtonOutlet.addShadow(color: CGColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1))
        mapWithCoordinatesView.layer.cornerRadius = 10
    }

    @IBAction func appointmentButtonAction(_ sender: UIButton) {
    }
    
}

//
//  SingleServiceViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 23.05.22.
//

import UIKit

class SingleServiceViewController: UIViewController {

    @IBOutlet weak var serviseNameLabel: UILabel!
    @IBOutlet weak var servicePriceLabel: UILabel!
    @IBOutlet weak var serviceDescriptionLabel: UILabel!
    @IBOutlet weak var advantageHeader1: UILabel!
    @IBOutlet weak var advantageHeader2: UILabel!
    @IBOutlet weak var advantageHeader3: UILabel!
    @IBOutlet weak var advantageBody1: UILabel!
    @IBOutlet weak var advantageBody2: UILabel!
    @IBOutlet weak var advantageBody3: UILabel!
    @IBOutlet weak var catalogButtonOutlet: UIButton!
    @IBOutlet weak var appointmentButtonOutlet: UIButton!
    
    var currentService: Service?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupViewControllerWithData()
        catalogButtonOutlet.setCapsuleRoundingToButton()
        appointmentButtonOutlet.setCapsuleRoundingToButton()
        catalogButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
        appointmentButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
//        appointmentButtonOutlet.addShadow(color: CGColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1), cornerRadius: 10)
    }
    
    func setupViewControllerWithData() {
        
        guard let item = currentService else { return }
        serviseNameLabel.text = item.name
        servicePriceLabel.text = "от " + String(item.price) + Const.belRublesSign
        serviceDescriptionLabel.text = item.description
        advantageHeader1.text = item.advantageHeaderFirst
        advantageBody1.text = item.advantageBodyFirst
        advantageHeader2.text = item.advantageHeaderSecond
        advantageBody2.text = item.advantageBodySecond
        advantageHeader3.text = item.advantageHeaderThird
        advantageBody3.text = item.advantageBodyThird
    }
    
    @IBAction func catalogButtonAction(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 2
    }
}

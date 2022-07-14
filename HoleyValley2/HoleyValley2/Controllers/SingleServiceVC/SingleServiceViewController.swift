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
    @IBOutlet weak var advantageHeaderFirst: UILabel!
    @IBOutlet weak var advantageHeaderSecond: UILabel!
    @IBOutlet weak var advantageHeaderThird: UILabel!
    @IBOutlet weak var advantageBodyFirst: UILabel!
    @IBOutlet weak var advantageBodySecond: UILabel!
    @IBOutlet weak var advantageBodyThird: UILabel!
    @IBOutlet weak var catalogButtonOutlet: UIButton!
    @IBOutlet weak var appointmentButtonOutlet: UIButton!
    @IBOutlet weak var likeImageFirst: UIImageView!
    @IBOutlet weak var likeImageSecond: UIImageView!
    @IBOutlet weak var likeImageThird: UIImageView!
    @IBOutlet weak var constraintWithAdvantages: NSLayoutConstraint!
    @IBOutlet weak var constraintWithoutAdvantages: NSLayoutConstraint!

    
    
    var currentService: Service?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupViewControllerWithData()
        catalogButtonOutlet.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        appointmentButtonOutlet.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)

//        catalogButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
//        appointmentButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
    }
    
    func setupViewControllerWithData() {
        
        guard let item = currentService else { return }
        serviseNameLabel.text = item.name
        servicePriceLabel.text = "от " + String(item.price) + Const.belRublesSign
        serviceDescriptionLabel.text = item.description
        if item.advantageHeaderFirst != "",
           item.advantageHeaderSecond != "",
           item.advantageHeaderThird != "" {
        advantageHeaderFirst.text = item.advantageHeaderFirst
        advantageBodyFirst.text = item.advantageBodyFirst
        advantageHeaderSecond.text = item.advantageHeaderSecond
        advantageBodySecond.text = item.advantageBodySecond
        advantageHeaderThird.text = item.advantageHeaderThird
        advantageBodyThird.text = item.advantageBodyThird
        } else {
            likeImageFirst.isHidden = true
            likeImageSecond.isHidden = true
            likeImageThird.isHidden = true
            advantageHeaderFirst.isHidden = true
            advantageHeaderSecond.isHidden = true
            advantageHeaderThird.isHidden = true
            advantageBodyFirst.isHidden = true
            advantageBodySecond.isHidden = true
            advantageBodyThird.isHidden = true
            constraintWithAdvantages.isActive = false
            constraintWithoutAdvantages.isActive = true
        }
    }
    
    @IBAction func catalogButtonAction(_ sender: UIButton) {
        
//        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
//        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 2
    }
}

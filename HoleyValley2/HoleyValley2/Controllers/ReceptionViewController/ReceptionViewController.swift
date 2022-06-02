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
    @IBOutlet weak var instagramLogo: UIImageView!
    @IBOutlet weak var tiktokLogo: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appointmentButtonOutlet.setCapsuleRoundingToButton()
        appointmentButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
        mapWithCoordinatesView.setRoundingToView(cornerRadius: 18)
        mapWithCoordinatesView.setShadowWithOffsetToView(color: Const.Colors.gray.cgColor)

//        instagramLogo.setRoundingToImage(cornerRadius: 18)
//        tiktokLogo.setRoundingToImage(cornerRadius: 18)
//        instagramLogo.setShadowToImage(color: Const.Colors.gray.cgColor)
//        tiktokLogo.setShadowToImage(color: Const.Colors.gray.cgColor)
        
        title = "Контакты"
        
        instagramAction()
        tiktokAction()
    }
    
    private func instagramAction() {
        
        let tapLogo = UITapGestureRecognizer(target: self, action: #selector(tapToInstagram(sender:)))
        instagramLogo.isUserInteractionEnabled = true
        instagramLogo.addGestureRecognizer(tapLogo)
    }
    
    @objc func tapToInstagram(sender: UITapGestureRecognizer) {
        
        if let targetURL = URL(string: "https://instagram.com/holey.valley.piercing/") {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        }
    }
    
    private func tiktokAction() {
        
        let tapLogo = UITapGestureRecognizer(target: self, action: #selector(tapToTiktok(sender:)))
        tiktokLogo.isUserInteractionEnabled = true
        tiktokLogo.addGestureRecognizer(tapLogo)
    }
    
    @objc func tapToTiktok(sender: UITapGestureRecognizer) {
        
        if let targetURL = URL(string: "https://vm.tiktok.com/ZMN1XXtLe/") {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
        let appointmentVC = AppointmentViewController(nibName: String(describing: AppointmentViewController.self), bundle: nil)
        
        navigationController?.pushViewController(appointmentVC, animated: true)
    }
    
}

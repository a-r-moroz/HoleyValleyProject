//
//  ReceptionViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit

class ReceptionViewController: UIViewController {

    @IBOutlet weak var mapWithCoordinatesView: UIView!
    @IBOutlet weak var disclaimerView: UIView!
    @IBOutlet weak var appointmentButton: UIButton!
    @IBOutlet weak var socialNetworksView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var telegramButton: UIButton!
    @IBOutlet weak var whatsAppButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var tikTokButton: UIButton!
    @IBOutlet weak var warningImage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Контакты"
        setupUI()
    }
    
    private func setupUI() {
        
        appointmentButton.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
//        appointmentButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
        mapWithCoordinatesView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        mapWithCoordinatesView.setShadowWithOffsetToView(color: Const.Colors.gray.cgColor)
        disclaimerView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
//        socialNetworksView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        phoneView.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        telegramButton.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        whatsAppButton.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        instagramButton.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        tikTokButton.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        
        warningImage.tintColor = .systemRed
//        warningImage.setShadowToImage(color: UIColor.systemRed.cgColor)
    }
    
//    private func goToApp(url: String, phoneNumber: String? = nil) {
//
//        if let phoneNumber = phoneNumber {
//
//            let targetURL = URL(string: url + phoneNumber)!
//
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(targetURL)
//            }
//        } else {
//
//            let targetURL = URL(string: url)!
//
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(targetURL)
//            }
//        }
//    }
    
    func makePhoneCall(phoneNumber: String) {
        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {
            
            UIApplication.shared.openURL(phoneURL as URL)
        }
    }
    
//    private func phoneAction() {
//
//        let tapLogo = UITapGestureRecognizer(target: self, action: #selector(didPressCall(sender:)))
//        phoneNumberLabel.isUserInteractionEnabled = true
//        phoneNumberLabel.addGestureRecognizer(tapLogo)
//    }
//
//    @objc func didPressCall(sender: UITapGestureRecognizer) {
//        let number = "375339907788"
//        if let url = URL(string: "tel://\(number)") { UIApplication.shared.open(url, options: [:], completionHandler: nil
//        )}
//    }
    
    @IBAction func telegramAction(_ sender: UIButton) {
        
        let phoneNumber = Const.salonPhoneNumberNoSpaces
        let targetURL = URL(string: Const.SocialNetworks.telegram + phoneNumber)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(targetURL)
        }
    }
    
    @IBAction func whatsAppAction(_ sender: UIButton) {
        
        let phoneNumber = Const.SocialNetworks.whatsApp
        let targetURL = URL(string: Const.SocialNetworks.whatsApp + phoneNumber)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(targetURL)
        }
    }
    
    @IBAction func instagramAction(_ sender: UIButton) {
        
        if let targetURL = URL(string: Const.SocialNetworks.instagram) {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func tikTokAction(_ sender: UIButton) {
        
        if let targetURL = URL(string: Const.SocialNetworks.tikTok) {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func phoneImageAction(_ sender: UIButton) {
        
        makePhoneCall(phoneNumber: Const.salonPhoneNumberNoSpaces)
    }
    
    @IBAction func phoneNumberAction(_ sender: UIButton) {
        
        makePhoneCall(phoneNumber: Const.salonPhoneNumberNoSpaces)
    }
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
        let appointmentVC = AppointmentViewController(nibName: String(describing: AppointmentViewController.self), bundle: nil)
        
        navigationController?.pushViewController(appointmentVC, animated: true)
    }
}

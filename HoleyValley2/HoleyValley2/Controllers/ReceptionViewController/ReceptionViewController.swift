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
    @IBOutlet weak var telegramLogo: UIImageView!
    @IBOutlet weak var wathsappLogo: UIImageView!
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
        whatsappAction()
        telegramAction()
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
    
    private func whatsappAction() {
        
        let tapLogo = UITapGestureRecognizer(target: self, action: #selector(tapWhatsapp(sender:)))
        wathsappLogo.isUserInteractionEnabled = true
        wathsappLogo.addGestureRecognizer(tapLogo)
    }
    
    @objc func tapWhatsapp(sender: UITapGestureRecognizer) {
        let phoneNumber =  "375339907788"
        let targetURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(targetURL)
        }
    }
    
    private func telegramAction() {
        
        let tapLogo = UITapGestureRecognizer(target: self, action: #selector(tapTelegram(sender:)))
        telegramLogo.isUserInteractionEnabled = true
        telegramLogo.addGestureRecognizer(tapLogo)
    }
    
    @objc func tapTelegram(sender: UITapGestureRecognizer) {
        let phoneNumber =  "375339907788"
        let targetURL = URL(string: "https://t.me/+\(phoneNumber)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(targetURL)
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
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
        let appointmentVC = AppointmentViewController(nibName: String(describing: AppointmentViewController.self), bundle: nil)
        
        navigationController?.pushViewController(appointmentVC, animated: true)
    }
    
}

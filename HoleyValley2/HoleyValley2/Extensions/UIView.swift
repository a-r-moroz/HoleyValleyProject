//
//  UIView.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 24.05.22.
//

import Foundation
import UIKit

extension UIView {
    
    func setRoundingToView(cornerRadius: CGFloat) {

        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setShadowToView(color: CGColor, cornerRadius: CGFloat) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.5 //0.3
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0.08 // 7, 15, 10
        self.layer.shadowOffset = .zero
//        self.layer.shadowOffset = CGSize(width: 0, height: 5)

        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setShadowWithOffsetToView(color: CGColor) {
        
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
//    func setShadowToImage(color: CGColor) {
//
//        self.layer.shadowColor = color
//        self.layer.shadowOpacity = 0.4
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = 20
//        self.layer.shadowOffset = .zero
//
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
//    }
    
    /*
    func makeTapOnView() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func makeLongTapOnView() {
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
        
        print("tapped")
        
        UIView.animate(withDuration: 0.5) {
            self.frame.size.height *= 0.9
            self.frame.size.width *= 0.9
        }
    }

    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        
        print("longpressed")
        
        UIView.animate(withDuration: 0.5) {
            self.frame.size.height *= 0.9
            self.frame.size.width *= 0.9
//            self.center = self.view.center
        }
    }
     */
    
}

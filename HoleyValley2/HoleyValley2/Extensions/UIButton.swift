//
//  UIButton.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 23.05.22.
//

import Foundation
import UIKit

extension UIButton {
    
    func setRoundingToButton(cornerRadius: CGFloat) {

        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
     }
    
    func setCapsuleRoundingToButton() {

        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
     }
    
    func setShadowToButton(color: CGColor) {
        
//        self.layer.shadowColor = color
//        self.layer.shadowOpacity = 1
//        self.layer.shadowOffset = .zero
//        self.layer.shadowRadius = 15 //10
//        self.layer.masksToBounds = false
        
//        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.35 // 0.3
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 15 //5
//        self.layer.shadowOffset = .zero
        self.layer.shadowOffset = CGSize(width: 0, height: 5)

        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

//
//  UIButton.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 23.05.22.
//

import Foundation
import UIKit

extension UIButton {
    
    func setRounding() {

        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
     }
    
    func addShadow(color: CGColor) {
        
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 15 //10
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

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
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5 // 15, 10
        self.layer.shadowOffset = .zero
//        self.layer.shadowOffset = CGSize(width: 0, height: 5)

        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
}

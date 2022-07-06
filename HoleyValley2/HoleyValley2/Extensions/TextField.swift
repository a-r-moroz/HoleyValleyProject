//
//  TextField.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.06.22.
//

import Foundation
import UIKit

extension UITextField {
    
    func setupTextFieldWithBorderAndPadding(color: CGColor, cornerRadius: CGFloat) {
        
        self.borderStyle = .none
        self.layer.borderColor = color
        self.layer.borderWidth = 1
        self.layer.cornerRadius = cornerRadius
        let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
        let paddingRightView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: self.frame.size.height))
        self.leftView = paddingLeftView
        self.rightView = paddingRightView
//        self.clearButtonRect(forBounds: self.bounds).offsetBy(dx: -10, dy: 0)
        self.leftViewMode = .always
//        self.rightViewMode = .always

    }
    
//    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
//
//        return CGRect(x: 300, y: 25, width: 40, height: 20)
//    }
    
//    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
//        let originalRect = super.clearButtonRect(forBounds: bounds)
//
//        return originalRect.offsetBy(dx: -8, dy: 0)
//    }
}


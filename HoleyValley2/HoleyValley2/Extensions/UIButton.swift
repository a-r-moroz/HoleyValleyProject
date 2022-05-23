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
     }}

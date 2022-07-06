//
//  NavigationBar.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 6.07.22.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
}

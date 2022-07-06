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

//        UINavigationBar.appearance().isTranslucent = false
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
//        UINavigationBar.appearance().barStyle = .black
        
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().backgroundColor = nil

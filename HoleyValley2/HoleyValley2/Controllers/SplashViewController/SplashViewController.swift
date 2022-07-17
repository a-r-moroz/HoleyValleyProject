//
//  SplashViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 24.05.22.
//

import UIKit

final class SplashViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIImageView!
    @IBOutlet weak var oldGradientConstraint: NSLayoutConstraint!
    @IBOutlet weak var oldTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var newGradientConstraint: NSLayoutConstraint!
    @IBOutlet weak var newTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var studioNameLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.oldGradientConstraint.isActive = false
        self.newGradientConstraint.isActive = true
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.curveEaseInOut]) {
            
            self.view.layoutIfNeeded()
        } completion: { finish in
            
        }
        
        self.oldTextConstraint.isActive = false
        self.newTextConstraint.isActive = true
        
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseOut]) {
            
            self.studioNameLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.layoutIfNeeded()
        } completion: { finish in
            UIView.animate(withDuration: 0.2, delay: 0.3) {
                self.view.alpha = 0.0
            }
        }
    }
}

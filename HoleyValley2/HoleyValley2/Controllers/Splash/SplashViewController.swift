//
//  SplashViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 21.05.22.
//

import UIKit

final class SplashViewController: UIViewController {

    @IBOutlet weak var gradientView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIView.animate(withDuration: 2.0) {
//            
//            self.oldConstrraint.isActive = false
//            self.newConstrraint.isActive = true
//            self.view.layoutIfNeeded() // перерисовка вью
//        }
        
//        UIView.transition(with: self.gradientView, duration: 2.0) {
//            self.oldConstrraint.isActive = false
//            self.newConstrraint.isActive = true
//            self.gradientView.transform = CAAnimation(
//        }
        
//        moveIt(gradientView, 1)
    }
    
//    func moveIt(_ imageView: UIImageView,_ speed: CGFloat) {
//        let speeds = speed
//        let imageSpeed = speeds / view.frame.size.width
//        let averageSpeed = (view.frame.size.width - imageView.frame.origin.x) * imageSpeed
//        UIView.animate(withDuration: TimeInterval(averageSpeed), delay: 2.0, options: .curveLinear, animations: {
//            imageView.frame.origin.x = self.view.frame.size.width
//        }, completion: { (_) in
//            imageView.frame.origin.x = -imageView.frame.size.width
//            self.moveIt(imageView,speeds)
//        })
//    }

}

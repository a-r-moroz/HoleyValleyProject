//
//  SplashViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 24.05.22.
//

import UIKit

final class SplashViewController: UIViewController {

    @IBOutlet weak var gradientView: UIImageView!
    @IBOutlet weak var oldConstraint: NSLayoutConstraint!
    @IBOutlet weak var newConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.oldConstraint.isActive = false
        self.newConstraint.isActive = true
        
        UIView.animate(withDuration: 1.5, delay: 0.2, options: [.curveEaseInOut]) {
            self.view.layoutIfNeeded()
        } completion: { finish in
            
        }
        
        
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//            let sceneDelegate = windowScene.delegate as? SceneDelegate
//            else { return }
//
//            sceneDelegate.splashController()

        
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

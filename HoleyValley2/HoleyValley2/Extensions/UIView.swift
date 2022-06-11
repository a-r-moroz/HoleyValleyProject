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
        self.layer.shadowOpacity = 0.5 //0.3
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0.08 // 7, 15, 10
        self.layer.shadowOffset = .zero
//        self.layer.shadowOffset = CGSize(width: 0, height: 5)

        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setShadowWithOffsetToView(color: CGColor) {
        
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func shake(count: Float = 5, for duration : TimeInterval = 0.5, withTranslation translation: Float = 3) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
    
    func strangeShake(_ view: UIView) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: view.center.y - 5))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))

        view.layer.add(animation, forKey: "position")
    }
    
    func verticalShake(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.2
        animation.repeatCount = 0.5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: view.center.y + 3))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: view.center.y - 3))
        view.layer.add(animation, forKey: "position")
    }
    
      
      enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
      }
      
      func startShimmeringAnimation(animationSpeed: Float = 1.4,
                                    direction: Direction = .leftToRight,
                                    repeatCount: Float = MAXFLOAT) {
        
        // Create color  ->2
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor
        
        // Create a CAGradientLayer  ->3
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
        
        switch direction {
        case .topToBottom:
          gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
          gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
          
        case .bottomToTop:
          gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
          gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
          
        case .leftToRight:
          gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
          gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
          
        case .rightToLeft:
          gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
          gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
        self.layer.mask = gradientLayer
        
        // Add animation over gradient Layer  ->4
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
          guard let strongSelf = self else { return }
          strongSelf.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
      }
      
      func stopShimmeringAnimation() {
        self.layer.mask = nil
      }
    
//    func setShadowToImage(color: CGColor) {
//
//        self.layer.shadowColor = color
//        self.layer.shadowOpacity = 0.4
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = 20
//        self.layer.shadowOffset = .zero
//
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
//    }
    
    /*
    func makeTapOnView() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func makeLongTapOnView() {
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
        
        print("tapped")
        
        UIView.animate(withDuration: 0.5) {
            self.frame.size.height *= 0.9
            self.frame.size.width *= 0.9
        }
    }

    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        
        print("longpressed")
        
        UIView.animate(withDuration: 0.5) {
            self.frame.size.height *= 0.9
            self.frame.size.width *= 0.9
//            self.center = self.view.center
        }
    }
     */
    
}

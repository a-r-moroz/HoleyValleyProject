//
//  UIImage.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 16.05.22.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromULR(_ url: String) {
        DispatchQueue.global().async {
            if let pictureUrl = URL(string: url) {
                if let data = try? Data(contentsOf: pictureUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }
        }
    }
}

//extension UIImageView {
//    override open func awakeFromNib() {
//
//      self.layoutIfNeeded()
//      layer.cornerRadius = self.frame.height / 10
//      layer.masksToBounds = true
//
//     }}

extension UIImageView {
    
    func setRounding() {

      self.layoutIfNeeded()
      layer.cornerRadius = 10
      layer.masksToBounds = true
     }}

//extension UIImageView {
//  func enableZoom() {
//    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
//    isUserInteractionEnabled = true
//    addGestureRecognizer(pinchGesture)
//  }
//
//  @objc
//  private func startZooming(_ sender: UIPinchGestureRecognizer) {
//    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
//    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
//    sender.view?.transform = scale
//    sender.scale = 1
//  }
//}

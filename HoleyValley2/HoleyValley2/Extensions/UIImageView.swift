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

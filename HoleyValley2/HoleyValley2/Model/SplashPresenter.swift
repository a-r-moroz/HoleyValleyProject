//
//  SplashPresenter.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 21.05.22.
//

import Foundation
import UIKit

protocol SplashPresenterDescription {
    func presentSplash()
    func dissmissSplash(completion: (() -> Void)?)
}

final class SplashPresenter: SplashPresenterDescription {
    
    let splashViewController = SplashViewController(nibName: String(describing: SplashViewController.self), bundle: nil)
                                                    
    private lazy var foregroundSplashWindow: UIWindow = {
        var splashWindow = UIWindow()
//        splashWindow = UIWindow(frame: UIScreen.main.bounds)
        splashWindow.windowLevel = .alert + 1
        splashWindow.rootViewController = splashViewController
//        splashWindow.makeKeyAndVisible()
        return splashWindow
            }()
    
    
    func presentSplash() {
        foregroundSplashWindow.isHidden = false
    }
    
    func dissmissSplash(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.3) {
            self.foregroundSplashWindow.alpha = 0
        } completion: { (_) in
            completion?()
        }
    }
}

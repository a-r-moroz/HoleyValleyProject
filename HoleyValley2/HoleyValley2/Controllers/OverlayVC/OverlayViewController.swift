//
//  OverlayViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 5.07.22.
//

import UIKit

class OverlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        blurView.alpha = 1.0
        self.view.addSubview(blurView)
        self.view.sendSubviewToBack(blurView)
        
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = self.view.frame
        blurView.effect = blurEffect
    }
    /*
     func setupBlur() {
         
         let blur = UIBlurEffect(style: .regular)
         let visualEffect = UIVisualEffectView(effect: blur)
         visualEffect.frame = backView.bounds
         visualEffect.alpha = 0.0
         view.addSubview(visualEffect)
         view.sendSubviewToBack(visualEffect)
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
             UIView.animate(withDuration: 0.4, delay: 0.02) {
                 visualEffect.alpha = 1
             }
         })
     }
     */
}

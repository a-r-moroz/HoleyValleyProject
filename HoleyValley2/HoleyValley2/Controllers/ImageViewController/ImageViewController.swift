//
//  ImageViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 20.05.22.
//

import UIKit

class ImageViewController: UIViewController {
        
    var imageScrollView: ImageScrollView!
    var imageToSet = UIImage()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        self.view.addSubview(imageScrollView)
        self.view.sendSubviewToBack(imageScrollView)
        setupImageScrollView()
        dismissBySwipe()
        
        self.imageScrollView.setImage(image: imageToSet)
    }
    
    func setupImageScrollView() {
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func dismissBySwipe() {
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(toSwipe))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
    }
    
    @objc func toSwipe(sender: UISwipeGestureRecognizer) {
        
        dismiss(animated: true)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}

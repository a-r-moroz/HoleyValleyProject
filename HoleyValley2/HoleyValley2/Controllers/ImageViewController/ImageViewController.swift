//
//  ImageViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 20.05.22.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var decorationImage: UIImageView!
    
    var imageToSet = UIImage()
    var scrollImage = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollImage.delegate = self
        scrollImage.minimumZoomScale = 1.0
        scrollImage.maximumZoomScale = 6.0
        var vWidth = self.view.frame.width
        var vHeight = self.view.frame.height
        scrollImage.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        self.view!.addSubview(scrollImage)
        scrollImage.addSubview(decorationImage)
        decorationImage!.clipsToBounds = false
        

        
        scrollImage.alwaysBounceVertical = false
        scrollImage.alwaysBounceHorizontal = false

        
        addPinch()
        decorationImage.image = imageToSet

    }

    @IBAction func closeAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    func addPinch() {
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        decorationImage.addGestureRecognizer(pinch)
    }
    
    @objc func pinchAction(_ sender: UIPinchGestureRecognizer) {
        
        if sender.state == .changed {
            
            let size = decorationImage.frame.height
            let scale = sender.scale
            let center = decorationImage.center
            decorationImage.frame = CGRect(x: 0, y: 0, width: size * scale, height: size * scale)
            decorationImage.layer.cornerRadius = decorationImage.frame.height / 2
            decorationImage.center = center
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.decorationImage
    }
}

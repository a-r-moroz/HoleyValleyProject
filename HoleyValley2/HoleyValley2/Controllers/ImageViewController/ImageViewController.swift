//
//  ImageViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 20.05.22.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var decorationImage: UIImageView!
    @IBOutlet weak var scrollImageView: UIScrollView!
    
    var imageToSet = UIImage()
//    var scrollImage = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollImageView.delegate = self
        scrollImageView.minimumZoomScale = 1.0
        scrollImageView.maximumZoomScale = 5.0
        scrollImageView.alwaysBounceVertical = false
        scrollImageView.alwaysBounceHorizontal = false
        scrollImageView.showsVerticalScrollIndicator = false
        scrollImageView.showsHorizontalScrollIndicator = false
        scrollImageView.flashScrollIndicators()
//        scrollImageView.
        

//        doudleTapGesture()

        
//        scrollImage.delegate = self
//        scrollImage.minimumZoomScale = 1.0
//        scrollImage.maximumZoomScale = 6.0
//        var vWidth = self.view.frame.width
//        var vHeight = self.view.frame.height
//        scrollImage.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
//        self.view.addSubview(scrollImage)
//        scrollImage.addSubview(decorationImage)
//        decorationImage!.clipsToBounds = false
//        scrollImage.alwaysBounceVertical = false
//        scrollImage.alwaysBounceHorizontal = false
//        scrollImage.showsVerticalScrollIndicator = false
//        scrollImage.flashScrollIndicators()
//
//        scrollImage.alwaysBounceVertical = false
//        scrollImage.alwaysBounceHorizontal = false
        
        decorationImage.image = imageToSet

    }
    
//    func doubleTapToZoom() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(doudleTapGesture))
//        tap.numberOfTapsRequired = 2
//        scrollImageView.addGestureRecognizer(tap)
//    }
//
//    @objc func doudleTapGesture() {
//        self.scrollImageView.zoomScale = 2
//    }

    @IBAction func closeAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return decorationImage
    }
}

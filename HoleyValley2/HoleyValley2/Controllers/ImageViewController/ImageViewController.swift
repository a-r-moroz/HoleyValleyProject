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
    @IBOutlet weak var decorationImageConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var decorationImageConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var decorationImageConstraintLeading: NSLayoutConstraint!
    @IBOutlet weak var decorationImageConstraintTrailing: NSLayoutConstraint!
    
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
        scrollViewDidZoom(scrollImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        centerImage()
    }
    
    //    func scrollViewDidZoom(scrollView: UIScrollView) {
    //    let subView = scrollView.subviews[0] // get the image view
    //    let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)
    //    let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
    //    // adjust the center of image view
    //    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY)
    //    }
    
    //    func doubleTapToZoom() {
    //        let tap = UITapGestureRecognizer(target: self, action: #selector(doudleTapGesture))
    //        tap.numberOfTapsRequired = 2
    //        scrollImageView.addGestureRecognizer(tap)
    //    }
    //
    //    @objc func doudleTapGesture() {
    //        self.scrollImageView.zoomScale = 2
    //    }
    
    func centerImage() {
        let boundsSize = scrollImageView.bounds.size
        var frameToCenter = view.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = boundsSize.width / 2
        } else {
            frameToCenter.origin.x = 0
        }
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        scrollImageView.frame = frameToCenter
    }
    
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return decorationImage
    }
        
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0, 0)
//        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0, 0)
//        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
        centerImage()
    }
}

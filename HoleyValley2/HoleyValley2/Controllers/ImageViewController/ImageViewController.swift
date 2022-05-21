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
        
        self.imageScrollView.set(image: imageToSet)
        
    }
    
    func setupImageScrollView() {
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}

    
    
    
    /*
    @IBOutlet weak var decorationImage: UIImageView!
    @IBOutlet weak var scrollImageView: UIScrollView!
    @IBOutlet weak var decorationImageConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var decorationImageConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var decorationImageConstraintLeading: NSLayoutConstraint!
    @IBOutlet weak var decorationImageConstraintTrailing: NSLayoutConstraint!
    
    var imageToSet = UIImage()
    lazy var doubleTapToZoom: UIGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doudleTapGesture))
        tap.numberOfTapsRequired = 2
        return tap
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        decorationImage.image = imageToSet
        scrollViewDidZoom(scrollImageView)
        
        setupScrollView()
        updateConstraintsForSize(view.bounds.size)
        updateMinZoomSize((view.bounds.size))
        
        scrollImageView.addGestureRecognizer(doubleTapToZoom)
        scrollImageView.isUserInteractionEnabled = true
        
//        scrollImageView.addGestureRecognizer(doubleTapToZoom)
//        scrollImageView.isUserInteractionEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func doudleTapGesture(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: sender.view)
        zoomAction(point: location, animated: true)
        }
    
    func zoomAction(point: CGPoint, animated: Bool) {
        let currentScale = scrollImageView.zoomScale
        let minScale = scrollImageView.minimumZoomScale
        let maxScale = scrollImageView.maximumZoomScale
        
        if (minScale == maxScale && minScale > 1) {
            return
        }
        
        let toScale = maxScale / 2
        let finalScale = (currentScale == minScale) ? toScale : minScale
        let zoomRect = zoomRect(scale: finalScale, center: point)
        scrollImageView.zoom(to: zoomRect, animated: animated)

    }
    
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = scrollImageView.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        
        return zoomRect


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
    
    
    func setupScrollView() {
        
        scrollImageView.delegate = self
        scrollImageView.alwaysBounceVertical = false
        scrollImageView.alwaysBounceHorizontal = false
        scrollImageView.showsVerticalScrollIndicator = false
        scrollImageView.showsHorizontalScrollIndicator = false
        scrollImageView.flashScrollIndicators()
        
        //        scrollImage.minimumZoomScale = 1.0
        //        scrollImage.maximumZoomScale = 6.0
        //        var vWidth = self.view.frame.width
        //        var vHeight = self.view.frame.height
        //        scrollImage.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        //        self.view.addSubview(scrollImage)
        //        scrollImage.addSubview(decorationImage)
        //        decorationImage!.clipsToBounds = false
        //        scrollImage.flashScrollIndicators()

    }
    
    func updateMinZoomSize(_ size: CGSize) {
        
        let widthScale = size.width / decorationImage.bounds.width
        let heigthScale = size.height / decorationImage.bounds.height
        let minScale = min(widthScale, heigthScale)
        
        scrollImageView.minimumZoomScale = minScale
        scrollImageView.maximumZoomScale = 2
        scrollImageView.zoomScale = minScale

    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - decorationImage.frame.height) / 2)
        decorationImageConstraintTop.constant = yOffset
        decorationImageConstraintBottom.constant = yOffset
        
        let xOffset = max(0, (size.width - decorationImage.frame.width) / 2)
        decorationImageConstraintLeading.constant = xOffset
        decorationImageConstraintTrailing.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    

}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.decorationImage
    }
        
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        updateConstraintsForSize(view.bounds.size)
    }
     
     */


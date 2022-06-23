//
//  DecorationViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.05.22.
//

import UIKit
import SDWebImage
import Haptica

class DecorationViewController: UIViewController {

    @IBOutlet weak var decorationImage: UIImageView!
    @IBOutlet weak var decorationNameLabel: UILabel!
    @IBOutlet weak var decorationPriceLabel: UILabel!
    @IBOutlet weak var decorationDescribtionLabel: UILabel!
    @IBOutlet weak var favoriteViewOutlet: FavoriteView!
    @IBOutlet weak var likeIndicator: UIImageView!
    
    var currentDecoration: Decoration?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        favoriteViewOutlet.viewDelegate = self
        
        setupViewControllerWithData()
        decorationImageTapped()
        decorationImage.setRoundingToImage(cornerRadius: 18)
    }
    
    func setupViewControllerWithData() {
        guard let item = currentDecoration else { return }
        decorationNameLabel.text = item.name
        decorationPriceLabel.text = String(item.price) + Const.belRublesSign
        decorationDescribtionLabel.text = item.description
        decorationImage.sd_setImage(with: URL(string: item.image), placeholderImage: UIImage(named: "imagePattern.png"))        
    }
    
    func decorationImageTapped() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        decorationImage.isUserInteractionEnabled = true
        decorationImage.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        
        let imageVC = ImageViewController(nibName: String(describing: ImageViewController.self), bundle: nil)
        
        guard let im = decorationImage.image else { return }
        imageVC.imageToSet = im
        imageVC.modalTransitionStyle = .coverVertical
        imageVC.modalPresentationStyle = .overFullScreen
        self.present(imageVC, animated: true)
        
    }
}

extension DecorationViewController: FavoriteViewDelegate {
    
    func likeAction() {
        
        likeIndicator.image = favoriteViewOutlet.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart.slash.fill")
        likeIndicator.alpha = 0.0
        likeIndicator.isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut]) { // 0.6 0.0
            
            self.likeIndicator.transform = CGAffineTransform(scaleX: 1.15, y: 1.15) //1.25
            
            UIView.animate(withDuration: 0.1, delay: 0.0) {
                self.likeIndicator.alpha = 0.5
                Haptic.play("o", delay: 0.1)
            } completion: { finish in
                UIView.animate(withDuration: 0.2, delay: 0.0) { // 0.2 0.1
                    self.likeIndicator.alpha = 0.0
                } completion: { finish in
                    self.likeIndicator.transform = CGAffineTransform(scaleX: 1, y: 1) // 0.8
                    Haptic.play("o", delay: 0.1)
                    self.likeIndicator.isHidden = true
                    self.loadViewIfNeeded()
                }
            }
        }
        
//        UIView.animateKeyframes(withDuration: 0.6, delay: 0.0, animations: {
//            self.likeIndicator.image
//
//            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.0, animations: {
//                self.likeIndicator.alpha = 0.5
//            } completion: { finish in
//                UIView.animate(withDuration: 0.2, delay: 0.2) {
//                    self.likeIndicator.alpha = 0.0
//                } completion: { finish in
//                    self.likeIndicator.isHidden = true
//                    self.loadViewIfNeeded()
//                }
//            }
//    })
//        })
    }
}

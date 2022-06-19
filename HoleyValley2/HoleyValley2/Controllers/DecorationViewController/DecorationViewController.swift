//
//  DecorationViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.05.22.
//

import UIKit
import SDWebImage

class DecorationViewController: UIViewController {

    @IBOutlet weak var decorationImage: UIImageView!
    @IBOutlet weak var decorationNameLabel: UILabel!
    @IBOutlet weak var decorationPriceLabel: UILabel!
    @IBOutlet weak var decorationDescribtionLabel: UILabel!
    @IBOutlet weak var favoriteViewOutlet: FavoriteView!
    
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
        print("Is liked")
    }
}

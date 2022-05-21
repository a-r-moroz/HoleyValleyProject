//
//  DecorationViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.05.22.
//

import UIKit

class DecorationViewController: UIViewController {

    @IBOutlet weak var decorationImage: UIImageView!
    @IBOutlet weak var decorationNameLabel: UILabel!
    @IBOutlet weak var decorationPriceLabel: UILabel!
    @IBOutlet weak var decorationDescribtionLabel: UILabel!
    
    var currentDecoration: Decoration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllerWithData()
        decorationImageTapped()
        decorationImage.setRounding()
    }
    
    func setupViewControllerWithData() {
        guard let item = currentDecoration else { return }
        decorationNameLabel.text = item.name
        decorationPriceLabel.text = String(item.price) + Constants.belRublesSign
        decorationDescribtionLabel.text = item.describtion
        decorationImage.setImageFromULR(item.image)
        
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

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
    }
    
    func setupViewControllerWithData() {
        guard let item = currentDecoration else { return }
        decorationNameLabel.text = item.name
        decorationPriceLabel.text = String(item.price) + Const.belRublesSign
        decorationDescribtionLabel.text = item.describtion
        decorationImage.setImageFromULR(item.image)
        
    }
}

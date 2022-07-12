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
    var favoriteDecoration = FavoriteDecorationRealm()
    var currentFavoriteDecoration: FavoriteDecorationRealm?
    var updateTable: (() -> ())?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        favoriteViewOutlet.viewDelegate = self
        
        setupViewControllerWithData()
        decorationImageTapped()
        decorationImage.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
//        guard let item = currentDecoration else { return }
//        let favoriteArray = RealmManager.read(type: FavoriteDecoration.self)
        
//        for i in favoriteArray {
//            if item.name == i.name {
//                if i.isLiked {
//                    favoriteViewOutlet.isLiked = true
//                } else {
//                    favoriteViewOutlet.isLiked = false
//                }
//            }
//        }
        
        checkDecorationIsLiked()
    }
    
    func checkDecorationIsLiked() {
        
        if let item = currentDecoration {
            favoriteDecoration.name = item.name
            favoriteDecoration.price = item.price
            favoriteDecoration.descrip = item.description
            favoriteDecoration.image = item.image
            favoriteDecoration.isLiked = favoriteViewOutlet.isLiked
            
            let favoriteArray = RealmManager.read(type: FavoriteDecorationRealm.self)
            if let objectToCheck = favoriteArray.filter({ $0.name == item.name }).first {
                favoriteDecoration.isLiked = true
                favoriteViewOutlet.isLiked = true
            } else {
                favoriteDecoration.isLiked = false
                favoriteViewOutlet.isLiked = false
            }
            
        } else if let favoriteItem = currentFavoriteDecoration {
        favoriteDecoration.name = favoriteItem.name
        favoriteDecoration.price = favoriteItem.price
        favoriteDecoration.descrip = favoriteItem.description
        favoriteDecoration.image = favoriteItem.image
        favoriteDecoration.isLiked = favoriteItem.isLiked
            
            let favoriteArray = RealmManager.read(type: FavoriteDecorationRealm.self)
            if let objectToCheck = favoriteArray.filter({ $0.name == favoriteItem.name }).first {
                favoriteDecoration.isLiked = true
                favoriteViewOutlet.isLiked = true
            } else {
                favoriteDecoration.isLiked = false
                favoriteViewOutlet.isLiked = false
        }
        } else { return }
        

        
        

//        for i in favoriteArray {
//            if favoriteDecoration.name != i.name {
//                favoriteDecoration.isLiked = false
//                favoriteViewOutlet.isLiked = false
//            } else {
//                favoriteDecoration.isLiked = true
//                favoriteViewOutlet.isLiked = true
//            }
//        }
    }
    
    func setupViewControllerWithData() {
        
        if let item = currentDecoration {
        decorationNameLabel.text = item.name
        decorationPriceLabel.text = String(item.price) + Const.belRublesSign
        decorationDescribtionLabel.text = item.description
        decorationImage.sd_setImage(with: URL(string: item.image), placeholderImage: UIImage(named: "imagePattern.png"))
        }
        
        if let favoriteItem = currentFavoriteDecoration {
            decorationNameLabel.text = favoriteItem.name
            decorationPriceLabel.text = String(favoriteItem.price) + Const.belRublesSign
            decorationDescribtionLabel.text = favoriteItem.descrip
            decorationImage.sd_setImage(with: URL(string: favoriteItem.image), placeholderImage: UIImage(named: "imagePattern.png"))
//            favoriteViewOutlet.isLiked = true
            favoriteViewOutlet.isLiked = favoriteItem.isLiked

        }
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
                Haptic.play("..", delay: 0.0)
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
        
        if let item = currentDecoration {
        
        favoriteDecoration.name = item.name
        favoriteDecoration.price = item.price
        favoriteDecoration.descrip = item.description
        favoriteDecoration.image = item.image
        favoriteDecoration.isLiked = favoriteViewOutlet.isLiked
        
        if favoriteViewOutlet.isLiked {
            
            RealmManager.add(object: FavoriteDecorationRealm(name: favoriteDecoration.name, price: favoriteDecoration.price, descrip: favoriteDecoration.descrip, image: favoriteDecoration.image, isLiked: true))
            updateTable?()

        } else {
            
            RealmManager.deleteDecoration(object: favoriteDecoration)
            updateTable?()
        }
        } else if let favoriteItem = currentFavoriteDecoration {
        
        favoriteDecoration.name = favoriteItem.name
        favoriteDecoration.price = favoriteItem.price
        favoriteDecoration.descrip = favoriteItem.description
        favoriteDecoration.image = favoriteItem.image
        favoriteDecoration.isLiked = favoriteViewOutlet.isLiked
        
        if favoriteViewOutlet.isLiked {
            
            RealmManager.add(object: FavoriteDecorationRealm(name: favoriteDecoration.name, price: favoriteDecoration.price, descrip: favoriteDecoration.descrip, image: favoriteDecoration.image, isLiked: true))
            updateTable?()

        } else {
            
            RealmManager.deleteDecoration(object: favoriteDecoration)
            updateTable?()
        }
        } else { return }
//        static func delegate(object: SavedCoordinates) {
//            let data = read()
//            guard let objectToDelete = data.filter({ $0.latitude == object.latitude && $0.longitude == object.longitude }).first else { return }
//
//            try? realm.write({
//                realm.delete(objectToDelete)
//            })
//        }
        
//        favoriteDecoration?.name = item.name
//        favoriteDecoration?.price = item.price
//        favoriteDecoration?.descrip = item.description
//        favoriteDecoration?.image = item.image
//        favoriteDecoration?.isLiked = ((favoriteDecoration?.isLiked.toggle()) != nil)
        
//        RealmManager.add(object: FavoriteDecoration(name: favoriteItem.name, price: favoriteItem.price, descrip: favoriteItem.descrip, image: favoriteItem.image, isLiked: true))
        
//        let favoriteArray = RealmManager.read(type: FavoriteDecoration.self)
//
//        for i in favoriteArray {
//            if favoriteDecoration.name != i.name {
//                if i.isLiked {
//                    RealmManager.add(object: FavoriteDecoration(name: favoriteItem.name, price: favoriteItem.price, descrip: favoriteItem.descrip, image: favoriteItem.image, isLiked: true))
//                } else {
//                    continue
//                }
//            } else {
//                RealmManager.remove(object: favoriteItem)
//            }
//        }
        
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

//
//  SingleServiceViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 23.05.22.
//

import UIKit

class SingleServiceViewController: UIViewController {

    @IBOutlet weak var serviseNameLabel: UILabel!
    @IBOutlet weak var servicePriceLabel: UILabel!
    @IBOutlet weak var serviceDescriptionLabel: UILabel!
    @IBOutlet weak var servicePhotosCollection: UICollectionView!
    @IBOutlet weak var advantageHeaderFirst: UILabel!
    @IBOutlet weak var advantageHeaderSecond: UILabel!
    @IBOutlet weak var advantageHeaderThird: UILabel!
    @IBOutlet weak var advantageBodyFirst: UILabel!
    @IBOutlet weak var advantageBodySecond: UILabel!
    @IBOutlet weak var advantageBodyThird: UILabel!
    @IBOutlet weak var catalogButtonOutlet: UIButton!
    @IBOutlet weak var appointmentButtonOutlet: UIButton!
    @IBOutlet weak var likeImageFirst: UIImageView!
    @IBOutlet weak var likeImageSecond: UIImageView!
    @IBOutlet weak var likeImageThird: UIImageView!
    @IBOutlet weak var constraintWithAdvantages: NSLayoutConstraint!
    @IBOutlet weak var constraintWithoutAdvantages: NSLayoutConstraint!
    @IBOutlet weak var oldConstraintUnderCollection: NSLayoutConstraint!
    @IBOutlet weak var newConstraintUnderCollection: NSLayoutConstraint!
    
    var currentService: Service?
    var servicePhotos: [String?] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupViewControllerWithData()
        catalogButtonOutlet.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        appointmentButtonOutlet.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)

//        catalogButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
//        appointmentButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
        
        setupCollection()
    }
    
    private func setupCollection() {
        
        servicePhotosCollection.delegate = self
        servicePhotosCollection.dataSource = self
        servicePhotosCollection.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
        servicePhotosCollection.register(UINib(nibName: String(describing: ServicePhotoCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ServicePhotoCell.self))
    }
    
    func setupViewControllerWithData() {
        
        guard let item = currentService else { return }
        serviseNameLabel.text = item.name
        servicePriceLabel.text = "от " + String(item.price) + Const.belRublesSign
        serviceDescriptionLabel.text = item.description
        
        if item.advantageHeaderFirst != "",
           item.advantageHeaderSecond != "",
           item.advantageHeaderThird != "" {
        advantageHeaderFirst.text = item.advantageHeaderFirst
        advantageBodyFirst.text = item.advantageBodyFirst
        advantageHeaderSecond.text = item.advantageHeaderSecond
        advantageBodySecond.text = item.advantageBodySecond
        advantageHeaderThird.text = item.advantageHeaderThird
        advantageBodyThird.text = item.advantageBodyThird
        
            servicePhotos = item.photos
            print("servicePhotos \(servicePhotos.count)")
//            for i in item.photos {
//                self.servicePhotos.append(i)
//            }
        
        } else {
            likeImageFirst.isHidden = true
            likeImageSecond.isHidden = true
            likeImageThird.isHidden = true
            advantageHeaderFirst.isHidden = true
            advantageHeaderSecond.isHidden = true
            advantageHeaderThird.isHidden = true
            advantageBodyFirst.isHidden = true
            advantageBodySecond.isHidden = true
            advantageBodyThird.isHidden = true
            servicePhotosCollection.isHidden = true
            constraintWithAdvantages.isActive = false
            constraintWithoutAdvantages.isActive = true
        }
        
//        servicePhotosCollection.isHidden = item.photos.isEmpty ? true : false
        
        if item.photos.isEmpty {
            servicePhotosCollection.isHidden = true
            oldConstraintUnderCollection.isActive = false
            newConstraintUnderCollection.isActive = true
        }
    }
    
    @IBAction func catalogButtonAction(_ sender: UIButton) {
        
//        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
//        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 2
    }
}

extension SingleServiceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return servicePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ServicePhotoCell.self), for: indexPath)
        guard let servicePhotoCell = cell as? ServicePhotoCell else { return cell }
        if let photoString = servicePhotos[indexPath.row] {
        servicePhotoCell.servicePhotoView.sd_setImage(with: URL(string: photoString), placeholderImage: UIImage(named: "imagePatternLittle.png"))
        }
        
        if servicePhotoCell.servicePhotoView == UIImage(named: "imagePatternLittle.png") {
            collectionView.isUserInteractionEnabled = false
        }
        
        return servicePhotoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ServicePhotoCell else { return }
        let imageVC = ImageViewController(nibName: String(describing: ImageViewController.self), bundle: nil)
        
        imageVC.imageToSet = cell.servicePhotoView.image ?? UIImage(named: "imagePatternLittle.png")!
        imageVC.modalTransitionStyle = .coverVertical
        imageVC.modalPresentationStyle = .overFullScreen
        self.present(imageVC, animated: true)
    }
    
//    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 134)
    }
}

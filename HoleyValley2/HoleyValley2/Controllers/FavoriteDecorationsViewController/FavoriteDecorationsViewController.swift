//
//  FavoriteDecorationsViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 8.07.22.
//

import UIKit

class FavoriteDecorationsViewController: UIViewController {

    @IBOutlet weak var favoriteDecorationsTable: UITableView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var favoriteDecorationsCollection: UICollectionView!
    
    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 16.0, bottom: 5.0, right: 16.0)
    private let itemsPerRow: CGFloat = 3
    let margin: CGFloat = 10
    
    var favoriteDecorations = RealmManager.read(type: FavoriteDecorationRealm.self) {
        didSet {
            favoriteDecorationsCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTable()
        setupCollection()
        title = "Избранные"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        favoriteDecorations = RealmManager.read(type: FavoriteDecorationRealm.self)
        favoriteDecorationsTable.reloadData()
        
        self.emptyImage.isHidden = self.favoriteDecorations.isEmpty ? false : true
    }
        
    private func setupTable() {
        
        favoriteDecorationsCollection.delegate = self
        favoriteDecorationsCollection.dataSource = self
        favoriteDecorationsCollection.register(UINib(nibName: String(describing: FavoriteDecorationCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FavoriteDecorationCollectionCell.self))
    }
    
    private func setupCollection() {
        
        favoriteDecorationsTable.delegate = self
        favoriteDecorationsTable.dataSource = self
        favoriteDecorationsTable.register(UINib(nibName: String(describing: DecorationCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DecorationCell.self))
        
        guard let collectionView = favoriteDecorationsCollection,
              let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        else { return }

           flowLayout.minimumInteritemSpacing = margin
           flowLayout.minimumLineSpacing = margin
           flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        favoriteDecorationsCollection.frame = view.bounds
    }
    
}

extension FavoriteDecorationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteDecorations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DecorationCell.self), for: indexPath)
        guard let favoriteDecorationCell = cell as? DecorationCell else { return cell }
        
        let favDecor = favoriteDecorations[indexPath.row]
        favoriteDecorationCell.decorationNameLabel.text = favDecor.name
        favoriteDecorationCell.decorationPriceLabel.text = String(favDecor.price) + Const.belRublesSign
        favoriteDecorationCell.decorationPictureView.sd_setImage(with: URL(string: favDecor.image), placeholderImage: UIImage(named: "imagePatternLittle.png"))
        
        return favoriteDecorationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let decorationVC = DecorationViewController(nibName: String(describing: DecorationViewController.self), bundle: nil)
        decorationVC.currentFavoriteDecoration = favoriteDecorations[indexPath.row]
        
        decorationVC.updateTable = {
             
            self.favoriteDecorationsTable.reloadData()
        }
        navigationController?.pushViewController(decorationVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            RealmManager.remove(object: self.favoriteDecorations[indexPath.row])
            self.favoriteDecorations = RealmManager.read(type: FavoriteDecorationRealm.self)
                self.favoriteDecorationsTable.reloadData()

        }
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return actions
    }
}

extension FavoriteDecorationsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favoriteDecorations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoriteDecorationCollectionCell.self), for: indexPath)
        
        guard let favCell = cell as? FavoriteDecorationCollectionCell else { return cell }
        
        let favDecor = favoriteDecorations[indexPath.row]

        favCell.decorationPictureView.sd_setImage(with: URL(string: favDecor.image), placeholderImage: UIImage(named: "imagePatternLittle.png"))
        favCell.decorationNameLabel.text = favDecor.name
        return favCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let decorationVC = DecorationViewController(nibName: String(describing: DecorationViewController.self), bundle: nil)
        decorationVC.currentFavoriteDecoration = favoriteDecorations[indexPath.row]
        
        decorationVC.updateTable = {
            self.favoriteDecorations = RealmManager.read(type: FavoriteDecorationRealm.self)
            self.favoriteDecorationsCollection.reloadData()
        }
        navigationController?.pushViewController(decorationVC, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150, height: 170)
//    }
}

extension FavoriteDecorationsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftAndRightPaddings: CGFloat = 30.0
        let numberOfItemsPerRow: CGFloat = 2.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width + 50)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: screenWidth, height: screenWidth)
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        return CGSize(width: (favoriteDecorationsCollection.frame.width / 2) - 2, height: 200.0)
//    }
    
//    // 1
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: Index
//    ) -> CGSize {
//        // 2
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//
//    // 3
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAt section: Int
//    ) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    // 4
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        return sectionInsets.left
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width / 2, height: view.frame.height / 2)
//    }
}

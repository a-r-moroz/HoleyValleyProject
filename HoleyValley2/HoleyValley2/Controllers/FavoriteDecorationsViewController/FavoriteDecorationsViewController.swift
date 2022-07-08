//
//  FavoriteDecorationsViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 8.07.22.
//

import UIKit

class FavoriteDecorationsViewController: UIViewController {

    @IBOutlet weak var favoriteDecorationsTable: UITableView!
    
    var favoriteDecorations = RealmManager.read(type: FavoriteDecoration.self) {
        didSet {
            favoriteDecorationsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTable()
        title = "Избранные украшения"
    }
    
    private func setupTable() {
        
        favoriteDecorationsTable.delegate = self
        favoriteDecorationsTable.dataSource = self
        favoriteDecorationsTable.register(UINib(nibName: String(describing: DecorationCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DecorationCell.self))
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
        navigationController?.pushViewController(decorationVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

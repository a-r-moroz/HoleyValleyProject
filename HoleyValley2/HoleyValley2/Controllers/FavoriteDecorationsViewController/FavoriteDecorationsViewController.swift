//
//  FavoriteDecorationsViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 8.07.22.
//

import UIKit

class FavoriteDecorationsViewController: UIViewController {

    @IBOutlet weak var favoriteDecorationsTable: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!

    
    var favoriteDecorations = RealmManager.read(type: FavoriteDecoration.self)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTable()
        title = "Избранные украшения"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        favoriteDecorationsTable.reloadData()
        
        self.emptyLabel.isHidden = self.favoriteDecorations.isEmpty ? false : true
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
        
        decorationVC.updateTable = {
            
            self.favoriteDecorationsTable.reloadData()
        }
        navigationController?.pushViewController(decorationVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            RealmManager.remove(object: self.favoriteDecorations[indexPath.row])
            self.favoriteDecorations = RealmManager.read(type: FavoriteDecoration.self)
                self.favoriteDecorationsTable.reloadData()

        }
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return actions
    }
}

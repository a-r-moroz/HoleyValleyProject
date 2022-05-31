//
//  CatalogViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase
//import RealmSwift

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var decorationsTable: UITableView!
    
    var database: DatabaseReference!
    
    var decorations = [Decoration]()
    var decorationsShtanga = [Decoration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorationsTable.delegate = self
        decorationsTable.dataSource = self
        setupTable()
//        decorations = FirebaseManager.getDecorations()
        
        title = "Каталог"
        
        loadDecorations()
        print("COUNT \n\(decorations.count)")
    }
    
    private func setupTable() {
        
        decorationsTable.register(UINib(nibName: String(describing: DecorationCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DecorationCell.self))
    }
    
    
    func loadDecorations() {
        
        database = Database.database().reference()
        decorations = []
            
        let query = self.database.child(Const.Firebase.decorationsPath).queryOrderedByKey()
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let description = value?["description"] as? String ?? ""
                let price = value?["price"] as? Int ?? 0
                let type = value?["type"] as? String ?? ""
                let picture = value?["picture"] as? String ?? ""
                
                let item = Decoration(name: name, price: price, description: description, type: type, image: picture)
                
                self.decorations.append(item)                
                DispatchQueue.main.async {
                    self.decorationsTable.reloadData()
                }
            }
        }
    }
}

extension CatalogViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let decorationVC = DecorationViewController(nibName: String(describing: DecorationViewController.self), bundle: nil)
        decorationVC.currentDecoration = decorations[indexPath.row]
        navigationController?.pushViewController(decorationVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension CatalogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return decorations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DecorationCell.self), for: indexPath)
        guard let decorationCell = cell as? DecorationCell else { return cell }
        
        let decor = decorations[indexPath.row]
        
        decorationCell.decorationNameLabel.text = decor.name
        decorationCell.decorationPriceLabel.text = String(decor.price) + Const.belRublesSign
        decorationCell.decorationPictureView.setImageFromULR(decor.image)

        decorationCell.previewName.isHidden = true
        decorationCell.previewPrice.isHidden = true
        
        print("INDEX: \n\(indexPath.row)")
        return decorationCell
    }
}

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
        
    }
    
    private func setupTable() {
        decorationsTable.register(UINib(nibName: String(describing: DecorationCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DecorationCell.self))
    }
    
    private func setupCell(cell: DecorationCell, row: Int) {
        
        self.view.isUserInteractionEnabled = false

//        cell.decorationPictureView.image = UIImage(named: "defaultImage")
//        cell.decorationPictureView.contentMode = .scaleAspectFill
        
        database = Database.database().reference()
        database.child("decorations").child("\(row)").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let value = snapshot.value as? NSDictionary else { return }
            
            let item = Decoration(name: value["name"] as? String ?? "",
                                  price: value["price"] as? Int ?? 0,
                                  description: value["description"] as? String ?? "",
                                  type: value["type"] as? String ?? "",
                                  image: value["picture"] as? String ?? Constants.defaultImage
            )
            
            cell.decorationPictureView.setImageFromULR(item.image)
            cell.decorationNameLabel.text = item.name
            cell.decorationPriceLabel.text = String(item.price) + Constants.belRublesSign

            self.decorations.append(item)
            
            self.view.isUserInteractionEnabled = true
            
        })
    }
    
    
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let decorationVC = DecorationViewController(nibName: String(describing: DecorationViewController.self), bundle: nil)
                decorationVC.currentDecoration = decorations[indexPath.row]
        //        let item = decorations[indexPath.row]
        navigationController?.pushViewController(decorationVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension CatalogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DecorationCell.self), for: indexPath)
        guard let decorationCell = cell as? DecorationCell else { return cell }
        setupCell(cell: decorationCell, row: indexPath.row)
        print("INDEX: \n\(indexPath.row)")
        return decorationCell
    }
    
    
}

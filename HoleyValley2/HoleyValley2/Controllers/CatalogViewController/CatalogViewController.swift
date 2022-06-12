//
//  CatalogViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase
import SDWebImage
//import RealmSwift

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var decorationsTable: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var database: DatabaseReference!
    
    var decorations = [Decoration]()
    var sortingDecorations = [Decoration]()
    var originalDecorations = [Decoration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        decorationsTable.delegate = self
        decorationsTable.dataSource = self
        setupTable()
//        decorations = FirebaseManager.getDecorations()
        
        title = "Каталог"
        
        loadDecorations()
        print("COUNT \n\(decorations.count)")
        
        addSortingButton()
        
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
            self.spinner.stopAnimating()
        }
    }
    
    private func addSortingButton() {
        
        let sortingButton = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain, target: self, action: #selector(showSortingVC(sender:)))
        navigationItem.rightBarButtonItem = sortingButton
    }
    
    @objc func showSortingVC(sender: UIBarButtonItem) {
        
//        let sortingVC = SortingViewController(nibName: String(describing: SortingViewController.self), bundle: nil)
//
//        navigationController?.pushViewController(sortingVC, animated: true)
        
        let sortingVC = SortingViewController(nibName: String(describing: SortingViewController.self), bundle: nil)
        
        sortingVC.modalTransitionStyle = .coverVertical
        sortingVC.modalPresentationStyle = .overFullScreen
        self.present(sortingVC, animated: true)
        
        sortingVC.saveSortingParameters = {
            print("Current value: \(sortingVC.currentType), \(sortingVC.currentPrice)")
            
            DispatchQueue.global().async {
                self.originalDecorations = self.decorations

            }
            
            if sortingVC.currentType != sortingVC.defaultSortingByType {
//                self.sortingDecorations = self.decorations.filter { decoration in
//                    return decoration.type == sortingVC.currentType }
                self.sortingDecorations = self.decorations.filter({ $0.type == sortingVC.currentType })
                self.decorations = self.sortingDecorations
                
                DispatchQueue.main.async {
                    self.decorationsTable.reloadData()
                }
                
//                let newArray = myArray
//                    .sorted { $0.mark < $1.mark }
//                    .map {$0.name}
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
        decorationCell.decorationPictureView.sd_setImage(with: URL(string: decor.image), placeholderImage: UIImage(named: "imagePatternLittle.png"))

        decorationCell.previewName.isHidden = true
        decorationCell.previewPrice.isHidden = true
        
        print("INDEX: \n\(indexPath.row)")
        return decorationCell
    }
}

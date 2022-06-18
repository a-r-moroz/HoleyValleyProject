//
//  CatalogViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase
import SDWebImage

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var decorationsTable: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var viewWithSearch: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var database: DatabaseReference!
    
    var decorations = [Decoration]()
    var sortingDecorations = [Decoration]()
    var originalDecorations = [Decoration]()
    var timer: Timer?
//    var searchBar = UISearchBar()
//    var searchField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        decorationsTable.delegate = self
        decorationsTable.dataSource = self
        
//        searchField = UITextField(frame: CGRect(x: 0, y: 0, width: decorationsTable.frame.size.width, height: 34.0))
//        searchField.placeholder = "Поиск"
//        decorationsTable.tableHeaderView = searchField
        
//        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: decorationsTable.frame.size.width, height: 44.0))
//        decorationsTable.tableHeaderView = searchBar
        
        setupTable()
//        decorations = FirebaseManager.getDecorations()
        
        title = "Каталог"
        
        loadDecorations()
        print("COUNT \n\(decorations.count)")
        
        addSortingButton()
        
        setupSearch()
        
        searchField.addTarget(self, action: #selector(textDidChange), for: .allEvents)
        
//        viewWithSearch.layer.cornerRadius = Const.CornerRadiusTo.viewAndImage
//        viewWithSearch.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
                self.originalDecorations.append(item)
                
                DispatchQueue.main.async {
                    self.decorationsTable.reloadData()
                }
            }
            self.spinner.stopAnimating()
        }
    }
    
    private func addSortingButton() {
        
        let sortingButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(showSortingVC(sender:)))
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
            
//            DispatchQueue.global().async {
//                self.originalDecorations = self.decorations
//            }
            
            print("Current value: \(sortingVC.currentType), \(sortingVC.currentPrice)")
            
            if sortingVC.currentType != sortingVC.defaultSortingByType && sortingVC.currentPrice != sortingVC.defaultSortingByPrice {
                
                if sortingVC.currentPrice == Const.priceDirecion.increace && sortingVC.currentType != sortingVC.defaultSortingByType {
                    
                    self.sortingDecorations = self.originalDecorations.sorted(by: { $0.price < $1.price }).filter({ $0.type == sortingVC.currentType })
                    self.decorations = self.sortingDecorations
                    self.reloadCatalogTable()
                    
                } else if sortingVC.currentPrice == Const.priceDirecion.decrease && sortingVC.currentType != sortingVC.defaultSortingByType {
                    
                    self.sortingDecorations = self.originalDecorations.sorted(by: { $0.price > $1.price }).filter({ $0.type == sortingVC.currentType })
                    self.decorations = self.sortingDecorations
                    self.reloadCatalogTable()
                }
                
            } else if sortingVC.currentType != Const.DecorationType.defaultType {

                self.sortingDecorations = self.originalDecorations.filter({ $0.type == sortingVC.currentType })
                self.decorations = self.sortingDecorations
                self.reloadCatalogTable()
                
            } else if sortingVC.currentPrice != sortingVC.defaultSortingByPrice {
                
                if sortingVC.currentPrice == Const.priceDirecion.increace {
                    
                    self.sortingDecorations = self.originalDecorations.sorted(by: { $0.price < $1.price })
                    self.decorations = self.sortingDecorations
                    self.reloadCatalogTable()
                    
                } else if sortingVC.currentPrice == Const.priceDirecion.decrease {
                    
                    self.sortingDecorations = self.originalDecorations.sorted(by: { $0.price > $1.price })
                    self.decorations = self.sortingDecorations
                    self.reloadCatalogTable()
                }
                
            } else {
                
                self.decorations = self.originalDecorations
                self.reloadCatalogTable()
            }
        }
    }
    
    private func reloadCatalogTable() {
        
        DispatchQueue.main.async {
            self.decorationsTable.reloadData()
        }
    }
    
    private func setupSearch() {
        
        searchField.borderStyle = .none
        searchField.layer.borderColor = UIColor.systemGray5.cgColor
        searchField.layer.borderWidth = 1
        searchField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchField.frame.size.height))
        self.searchField.leftView = paddingView
        self.searchField.leftViewMode = .always
    }
    
    @objc func textDidChange() {

        self.timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            if self.searchField.text != "" {
                self.decorations = self.originalDecorations.filter({ $0.name.contains(self.searchField.text ?? "") })
                self.reloadCatalogTable()
                
                self.emptyLabel.isHidden = self.decorations.isEmpty ? false : true
                
            } else {
                self.decorations = self.originalDecorations
                self.reloadCatalogTable()
                self.emptyLabel.isHidden = true
            }
        })
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

//extension CatalogViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
//    }
//}

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
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var viewForSpinner: UIView!
    
    var database: DatabaseReference!
    var decorations = [Decoration]()
    var sortingDecorations = [Decoration]()
    var originalDecorations = [Decoration]()
    var timer: Timer?
    
//    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        spinner.startAnimating()
        self.tabBarController?.delegate = self
        setupTable()
        loadDecorations()
        title = "Каталог"
        addSortingButton()
        addSearchBar()
        
//        decorations = FirebaseManager.getDecorations()
    }
    
    private func addSearchBar() {
        
//        searchBar.placeholder = "Поиск"
//        searchBar.sizeToFit()
//        navigationItem.titleView = searchBar
        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
    }
    
    private func setupTable() {
        
        decorationsTable.delegate = self
        decorationsTable.dataSource = self
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
//                let pictureString = value?["picture"] as? String ?? ""
                let picture = value?["picture"] as? String ?? ""

//                var picture = UIImage()
//
//                guard let pictureUrl = URL(string: pictureString) else { return }
                
//                DispatchQueue.global().async {
//                    if let data = try? Data(contentsOf: pictureUrl) {
//                        if let image = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                picture = image
//                            }
//                        }
//                    }
//                }
                
//                if let pictureUrl = URL(string: pictureString) {
//                    if let pictureData = try? Data(contentsOf: pictureUrl) {
//                        picture = UIImage(data: pictureData)!
//                    }
//                }
                
                let item = Decoration(name: name, price: price, description: description, type: type, image: picture)
                
                self.decorations.append(item)
                self.originalDecorations.append(item)
                
                DispatchQueue.main.async {
                    self.decorationsTable.reloadData()
                }
            }
            self.spinner.stopAnimating()
            self.viewForSpinner.isHidden = true
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
        
        if let sheet = sortingVC.sheetPresentationController {
            sheet.detents = [ .medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.preferredCornerRadius = Const.CornerRadiusTo.sheetController
        }
        
//        sortingVC.modalTransitionStyle = .coverVertical
//        sortingVC.modalPresentationStyle = .overFullScreen
        
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
        
        self.present(sortingVC, animated: true)
    }
    
    private func reloadCatalogTable() {
        
        DispatchQueue.main.async {
            self.decorationsTable.reloadData()
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
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        if(velocity.y>0) {
//            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//
//
//        } else {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//
//          }
//    }
//
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (scrollView.panGestureRecognizer.translation(in: scrollView.superview).y >= 0) {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        } else {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//
//        }
//    }
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
//        decorationCell.decorationPictureView.setImageFromULR(decor.image)
        decorationCell.decorationPictureView.sd_setImage(with: URL(string: decor.image), placeholderImage: UIImage(named: "imagePatternLittle.png"))
        
        print("INDEX: \n\(indexPath.row)")
        return decorationCell
    }
}

extension CatalogViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            
            if viewController.viewIfLoaded?.window != nil {
                decorationsTable.setContentOffset(CGPoint.zero, animated: true)
                print("1 selected")
            }
        }
    }
    
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        
//        let selectedIndex = tabBarController?.selectedIndex
//        let currentIndex = tabBar.items?.firstIndex(of: item)
//        if selectedIndex == 1 && currentIndex == 1 {
//            decorationsTable.setContentOffset(CGPoint.zero, animated: true)
//            decorationsTable.scrollsToTop = true
//            print("1 selected")
//        }
//    }
}
extension CatalogViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        print(text)
        
        self.timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            if text != "" {
                self.decorations = self.originalDecorations.filter({ $0.name.lowercased().contains(text.lowercased()) })
                self.reloadCatalogTable()
                self.emptyImage.isHidden = self.decorations.isEmpty ? false : true
            } else {
                self.decorations = self.originalDecorations
                self.reloadCatalogTable()
                self.emptyImage.isHidden = true
            }
        })
    }
}

//extension CatalogViewController: UISearchBarDelegate {
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton
//        cancelButton.setTitle("Отменить", for: .normal)
//    }
//}

//
//  SortingViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 5.06.22.
//

import UIKit

class SortingViewController: UIViewController {

    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var cleanButtonOutlet: UIButton!
    @IBOutlet weak var sortingParametersTable: UITableView!
    @IBOutlet weak var backView: UIView!
    
    let sortingPoints = SortingPoints.allCases
    var currentType = "Все украшения"
    var currentPrice = "-"
    let defaultSortingByType = "Все украшения"
    let defaultSortingByPrice = "-"
    var saveSortingParameters: (() -> ())?
    var currentTypeButtonHeader = "Все украшения"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        backView.layer.cornerRadius = Const.CornerRadiusTo.viewAndImage
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        saveButtonOutlet.setCapsuleRoundingToButton()
        saveButtonOutlet.setShadowWithOffsetToView(color: Const.Colors.gray.cgColor, cornerRadius: Const.CornerRadiusTo.viewAndImage)
        setupTable()
    }
    
    private func setupTable() {
     
        sortingParametersTable.delegate = self
        sortingParametersTable.dataSource = self
        sortingParametersTable.register(UINib(nibName: String(describing: SortingCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SortingCell.self))
    }
    
    func setupBlur() {
        
        let blur = UIBlurEffect(style: .regular)
        let visualEffect = UIVisualEffectView(effect: blur)
        visualEffect.frame = backView.bounds
        visualEffect.alpha = 0.0
        view.addSubview(visualEffect)
        view.sendSubviewToBack(visualEffect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            UIView.animate(withDuration: 0.4, delay: 0.02) {
                visualEffect.alpha = 1
            }
        })
    }
    
    @IBAction func cleanAction(_ sender: UIButton) {
        
    }
    
    @IBAction func saveSortingParametersAction(_ sender: UIButton) {
        
        saveSortingParameters?()
        dismiss(animated: true)
    }
}

extension SortingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SortingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortingPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SortingCell.self), for: indexPath)
        guard let sortingCell = cell as? SortingCell else { return cell }
        
        sortingCell.setupCellWith(sortingPoints[indexPath.row])
        
        switch sortingPoints[indexPath.row] {
            
        case .decorationType:
            
            let popUpSortingMenu = {(action: UIAction) in
                
//                action.title = UserDefaults.standard.string(forKey: "currentType") ?? Const.DecorationType.defaultType
                self.currentType = action.title
                sortingCell.sortingButtonOutlet.titleLabel?.text = action.title
//                if let sortingTitle = UserDefaults.standard.string(forKey: "sortingTitle") {
//                sortingCell.sortingButtonOutlet.titleLabel?.text = sortingTitle
//                } else {
//                    UserDefaults.standard.set(action.title, forKey: "sortingTitle")
//                }
//                print(self.currentType)
            }
            
            sortingCell.sortingButtonOutlet.menu = UIMenu(
                title: "Выберите тип украшения",
                options: .singleSelection,
                children: [UIAction(title: Const.DecorationType.defaultType, state: .on, handler: popUpSortingMenu),
                           UIAction(title: Const.DecorationType.banan, handler: popUpSortingMenu),
                           UIAction(title: Const.DecorationType.kolco, handler: popUpSortingMenu),
                           UIAction(title: Const.DecorationType.labret, handler: popUpSortingMenu),
                           UIAction(title: Const.DecorationType.nostrill, handler: popUpSortingMenu),
                           UIAction(title: Const.DecorationType.top, handler: popUpSortingMenu),
                           UIAction(title: Const.DecorationType.shtanga, handler: popUpSortingMenu),
                           UIAction(title: Const.DecorationType.circular, handler: popUpSortingMenu)])
            sortingCell.sortingButtonOutlet.showsMenuAsPrimaryAction = true
            sortingCell.sortingButtonOutlet.changesSelectionAsPrimaryAction = true
            
        case .price:
            
            let popUpSortingMenu = {(action: UIAction) in
                self.currentPrice = action.title
                print(self.currentPrice)
            }
            
            sortingCell.sortingButtonOutlet.menu = UIMenu(
                title: "Возрастание или убывание цены",
                options: .singleSelection,
                children: [UIAction(title: Const.priceDirecion.defaultState, state: .on, handler: popUpSortingMenu),
                           UIAction(title: Const.priceDirecion.increace, handler: popUpSortingMenu),
                           UIAction(title: Const.priceDirecion.decrease, handler: popUpSortingMenu)])
            
            sortingCell.sortingButtonOutlet.showsMenuAsPrimaryAction = true
            sortingCell.sortingButtonOutlet.changesSelectionAsPrimaryAction = true
        }
        
        return sortingCell
    }
}

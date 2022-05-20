//
//  BarController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit

class BarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
    }
    
    private func setupControllers() {
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        
        let servicesVC = UINavigationController(rootViewController: ServicesViewController())
        let catalogVC = UINavigationController(rootViewController: CatalogViewController())
        let receptionVC = UINavigationController(rootViewController: ReceptionViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        servicesVC.navigationBar.tintColor = UIColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1.0)
        catalogVC.navigationBar.tintColor = UIColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1.0)
        receptionVC.navigationBar.tintColor = UIColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1.0)
        profileVC.navigationBar.tintColor = UIColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1.0)

        
        servicesVC.tabBarItem = UITabBarItem(title: "Услуги", image: UIImage(systemName: "star.fill")?.withConfiguration(iconConfig), tag: 0)
        catalogVC.tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "square.grid.3x3.fill")?.withConfiguration(iconConfig), tag: 0)
        receptionVC.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(systemName: "location.magnifyingglass")?.withConfiguration(iconConfig), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill")?.withConfiguration(iconConfig), tag: 0)
        
        self.viewControllers = [servicesVC, catalogVC, receptionVC, profileVC]
    }
    
    
//    line.3.crossed.swirl.circle.fill
//    fanblades.fill
//    photo.on.rectangle.angled
}

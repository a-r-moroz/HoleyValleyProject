//
//  SettingsViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 12.06.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTable: UITableView!
    
    let sections = SettingsSections.allCases
    let settings = SettingsPoints.allCases
    var changeBackground = false
    var cellLowAlpha = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        
        settingsTable.dataSource = self
        settingsTable.delegate = self
        settingsTable.register(UINib(nibName: String(describing: SettingsCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SettingsCell.self))
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if indexPath.row == 1 {
//
//            let notificationsSettingsVC = NotificationsSettingsViewController(nibName: String(describing: NotificationsSettingsViewController.self), bundle: nil)
//            notificationsSettingsVC.modalTransitionStyle = .coverVertical
//            notificationsSettingsVC.modalPresentationStyle = .overFullScreen
//            self.present(notificationsSettingsVC, animated: true)
//        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionTitle
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var imageView: UIImageView
//        var image = sections[section].sectionImage
//        imageView.image = image
//        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.addSubview(header)
//        return header
        
//        var imageView = UIImageView()
//        imageView.image = sections[section].sectionImage
//        return imageView
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsCell.self), for: indexPath)
        guard let settingCell = cell as? SettingsCell else { return cell }
        settingCell.setupCellWith(settings[indexPath.row])
        
        settingCell.settingSwitch.isOn = changeBackground
        
        switch settings[indexPath.row] {
        case .notifications:
            settingCell.accessoryType = .none
            settingCell.selectionStyle = .none
            settingCell.switchAction = { isOn in
                self.changeBackground = !self.changeBackground
//                self.cellLowAlpha = !self.cellLowAlpha
//                UIApplication.shared.unregisterForRemoteNotifications()

                self.view.backgroundColor = self.changeBackground ? .systemRed : .white
            }
//        case .notificationsTime:
//            settingCell.settingSwitch.isHidden = true
//            settingCell.settingNameLabel.alpha = self.cellLowAlpha ? 0.5 : 1.0
        }
        
        return settingCell
    }
    
    
}

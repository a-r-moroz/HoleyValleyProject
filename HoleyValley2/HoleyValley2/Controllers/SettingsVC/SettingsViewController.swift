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
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

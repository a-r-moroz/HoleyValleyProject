//
//  CatalogViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
//import RealmSwift

class CatalogViewController: UIViewController {

    @IBOutlet weak var decorationsTable: UITableView!
    
//    var decorations = RealmManager.read(type: Decorations.self)
    
//    let username = "default2"
//    var config = Realm.Configuration.defaultConfiguration
//    config.fileURL?.deletingLastPathComponent()
//    config.fileURL!.appendPathComponent(username)
//    config.fileURL!.appendPathExtension("default2")
//    let realm = try! Realm(configuration: config)
    
//    let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)!.appendingPathComponent("default2")
//
//    var config = Realm.Configuration(fileURL: fileURL)
    
    var decorations = [Decoration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorationsTable.delegate = self
        decorationsTable.dataSource = self
        setupTable()
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        // ///Users/andrewmoroz/Library/Developer/CoreSimulator/Devices/9AA12F1F-9F28-47F0-A25E-B55C71AF539A/data/Containers/Data/Application/BFF7EE7D-EFE8-4A96-A911-8067DC9519D4/Documents/default.realm
    }
    
    private func setupTable() {
        decorationsTable.register(UINib(nibName: String(describing: DecorationCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DecorationCell.self))
    }
    
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        decorationCell.setupCell(row: indexPath.row)
//        decorationCell.decorationPictureView.image = UIImage(data: decorations[indexPath.row].picture!)
        decorations = decorationCell.decorations
        return decorationCell
    }
    
    
}

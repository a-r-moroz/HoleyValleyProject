//
//  MastersViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 20.06.22.
//

import UIKit
import Firebase
import SDWebImage

class MastersViewController: UIViewController {

    @IBOutlet weak var mastersTable: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var selectMasterButtonOutlet: UIButton!
    
    var masters = [Master]()
    var database: DatabaseReference!
    var selectedMaster: Master? = nil
    var postMaster: (() -> ())?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.spinner.startAnimating()
        setupTable()
        loadMasters()
        selectMasterButtonOutlet.setCapsuleRoundingToButton()
        selectMasterButtonOutlet.setShadowToButton(color: Const.Colors.gray.cgColor)
    }

    private func setupTable() {
        mastersTable.register(UINib(nibName: String(describing: MasterCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MasterCell.self))
        self.mastersTable.delegate = self
        self.mastersTable.dataSource = self
        self.mastersTable.allowsSelection = true
        self.mastersTable.allowsMultipleSelection = false
    }
    
    private func loadMasters() {
        
        database = Database.database().reference()
        masters = []
        
        let query = self.database.child(Const.Firebase.mastersPath).queryOrderedByKey()
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let surname = value?["surname"] as? String ?? ""
                let experience = value?["experience"] as? String ?? ""
                let description = value?["description"] as? String ?? ""
                let photo = value?["photo"] as? String ?? ""
                let id = child.key as String
                
                let item = Master(name: name, surname: surname, experience: experience, description: description, photo: photo, id: id)
                
                self.masters.append(item)
                
                DispatchQueue.main.async {
                    self.mastersTable.reloadData()
                }
            }
            self.spinner.stopAnimating()
        }
    }

    @IBAction func selectMasterAction(_ sender: UIButton) {
        
        if selectedMaster != nil {
            navigationController?.popViewController(animated: true)
        } else {
            let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
            let alert = UIAlertController(title: "Упс!", message: "Пожалуйста, выберите мастера, чтобы продолжить.", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
}

extension MastersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return masters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MasterCell.self), for: indexPath)
        guard let masterCell = cell as? MasterCell else { return cell }
        
        let master = masters[indexPath.row]

        masterCell.nameLabel.text = master.name
        masterCell.experienceLabel.text = master.experience
        masterCell.descriptionLabel.text = master.description
        masterCell.masterPhoto.sd_setImage(with: URL(string: master.photo), placeholderImage: UIImage(systemName: "person.fill"))
        return masterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) as? MasterCell else { return }
        
        if cell.isSelectedCell == false {
            cell.viewWithData.layer.borderWidth = 1
            cell.viewWithData.layer.borderColor = Const.Colors.gold.cgColor
            cell.viewWithData.backgroundColor = Const.Colors.gold.withAlphaComponent(0.1)
            cell.isSelectedCell = true
            
            selectedMaster = masters[indexPath.row]
            postMaster?()
            print(selectedMaster?.name ?? "")
        } else {
            cell.viewWithData.layer.borderWidth = 0
            cell.viewWithData.layer.borderColor = nil
            cell.viewWithData.backgroundColor = .secondarySystemBackground
            cell.isSelectedCell = false
            
            selectedMaster = nil
            print(selectedMaster?.name ?? "Not selected!")
        }
        

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MasterCell else { return }

        cell.viewWithData.layer.borderWidth = 0
        cell.viewWithData.layer.borderColor = nil
        cell.viewWithData.backgroundColor = .secondarySystemBackground
        cell.isSelectedCell = false
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        guard let cell = tableView.cellForRow(at: indexPath) as? MasterCell else { return }
//        cell.viewWithData.layer.borderWidth = 1
//        cell.viewWithData.layer.borderColor = Const.Colors.gold.cgColor
//    }
//
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//
//        guard let cell = tableView.cellForRow(at: indexPath) as? MasterCell else { return nil }
//
//        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
//            indexPathForSelectedRow == indexPath {
//            cell.viewWithData.layer.borderWidth = 0
//            cell.viewWithData.layer.borderColor = nil
//            tableView.deselectRow(at: indexPath, animated: false)
//            return nil
//        }
//        return indexPath
//    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if tableView.indexPathsForSelectedRows?.contains(indexPath) ?? false {
//           tableView.deselectRow(at: indexPath, animated: true)
//           return nil
//        }
//
//        return indexPath
//    }
//
//    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
//        return nil
//    }
    
}

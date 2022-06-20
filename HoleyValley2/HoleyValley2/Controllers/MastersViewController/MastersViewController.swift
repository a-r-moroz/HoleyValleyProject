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
    
    var masters = [Master]()
    var database: DatabaseReference!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.spinner.startAnimating()
        setupTable()
        loadMasters()
    }

    private func setupTable() {
        mastersTable.register(UINib(nibName: String(describing: MasterCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MasterCell.self))
        mastersTable.delegate = self
        mastersTable.dataSource = self
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
                
                let item = Master(name: name, surname: surname, experience: experience, description: description, photo: photo)
                
                self.masters.append(item)
                
                DispatchQueue.main.async {
                    self.mastersTable.reloadData()
                }
            }
            self.spinner.stopAnimating()
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
        
    }
    
}

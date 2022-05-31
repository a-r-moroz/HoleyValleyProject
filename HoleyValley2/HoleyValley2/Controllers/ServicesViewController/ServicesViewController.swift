//
//  ServicesViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase

class ServicesViewController: UIViewController {
    
    @IBOutlet weak var servicesTable: UITableView!
    var database: DatabaseReference!
    var services = [Service]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        servicesTable.delegate = self
        servicesTable.dataSource = self
        
        setupTable()
        loadServices()
        title = "Услуги"

//        services = FirebaseManager.getServices()
    }
    
    func setupTable() {
        
        let nib = UINib(nibName: String(describing: ServiceCell.self), bundle: nil)
        servicesTable.register(nib, forCellReuseIdentifier: String(describing: ServiceCell.self))
    }
    
    func loadServices() {
        
        database = Database.database().reference()
        services = []
            
        let query = self.database.child(Const.Firebase.servicesPath).queryOrderedByKey()
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let value = child.value as? NSDictionary
                
                let name = value?["name"] as? String ?? ""
                let price = value?["price"] as? Int ?? 0
                let description = value?["description"] as? String ?? ""
                let advantageHeader1 = value?["advantageHeader1"] as? String ?? ""
                let advantageHeader2 = value?["advantageHeader2"] as? String ?? ""
                let advantageHeader3 = value?["advantageHeader3"] as? String ?? ""
                let advantageBody1 = value?["advantageBody1"] as? String ?? ""
                let advantageBody2 = value?["advantageBody2"] as? String ?? ""
                let advantageBody3 = value?["advantageBody3"] as? String ?? ""
                
                /*
                 let item = Service(name: value["name"] as? String ?? "",
                                    price: value["price"] as? Int ?? 0,
                                    description: value["description"] as? String ?? "",
                                    advantageHeader1: value["advantageHeader1"] as? String ?? "",
                                    advantageBody1: value["advantageBody1"] as? String ?? "",
                                    advantageHeader2: value["advantageHeader2"] as? String ?? "",
                                    advantageBody2: value["advantageBody2"] as? String ?? "",
                                    advantageHeader3: value["advantageHeader3"] as? String ?? "",
                                    advantageBody3: value["advantageBody3"] as? String ?? ""
                 )
                 */

                let item = Service(name: name, price: price, description: description, advantageHeader1: advantageHeader1, advantageBody1: advantageBody1, advantageHeader2: advantageHeader2, advantageBody2: advantageBody2, advantageHeader3: advantageHeader3, advantageBody3: advantageBody3)
                
                self.services.append(item)
                
                DispatchQueue.main.async {
                    self.servicesTable.reloadData()
                }
            }
        }
    }
}

extension ServicesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let serviceVC = SingleServiceViewController(nibName: String(describing: SingleServiceViewController.self), bundle: nil)
        serviceVC.currentService = services[indexPath.row]
        navigationController?.pushViewController(serviceVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ServiceCell.self), for: indexPath)
        guard let serviceCell = cell as? ServiceCell else { return cell }
        
        let service = services[indexPath.row]
        serviceCell.serviceName.text = service.name
        serviceCell.servicePrice.text = "от " + String(service.price) + Const.belRublesSign
        serviceCell.previewName.isHidden = true
        serviceCell.previewPrice.isHidden = true
        
        return serviceCell
    }
}

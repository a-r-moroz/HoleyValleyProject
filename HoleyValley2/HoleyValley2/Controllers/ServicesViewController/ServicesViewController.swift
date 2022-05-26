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
        title = "Услуги"

//        services = FirebaseManager.getServices()
    }
    
    func setupTable() {
        
        let nib = UINib(nibName: String(describing: ServiceCell.self), bundle: nil)
        servicesTable.register(nib, forCellReuseIdentifier: String(describing: ServiceCell.self))
    }
    
    private func setupCell(cell: ServiceCell, row: Int) {
        
        self.view.isUserInteractionEnabled = false
        
        database = Database.database().reference()
        database.child("services").child("\(row)").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let value = snapshot.value as? NSDictionary else { return }
            
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
            
            cell.serviceName.text = item.name
            cell.servicePrice.text = "от " + String(item.price) + Constants.belRublesSign

            self.services.append(item)
            
            cell.previewName.isHidden = true
            cell.previewPrice.isHidden = true
            
            self.view.isUserInteractionEnabled = true
            
        })
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
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ServiceCell.self), for: indexPath)
        guard let serviceCell = cell as? ServiceCell else { return cell }

        setupCell(cell: serviceCell, row: indexPath.row)

        return serviceCell
    }
}

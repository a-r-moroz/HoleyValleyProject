//
//  AppointmentsTableViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 11.07.22.
//

import UIKit

class AppointmentsTableViewController: UIViewController {

    @IBOutlet weak var appointmentsTable: UITableView!
    
    var appointments = RealmManager.read(type: AppointmentRealm.self)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        appointmentsTable.reloadData()
    }
    
    private func setupTable() {
        appointmentsTable.register(UINib(nibName: String(describing: AppointmentCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AppointmentCell.self))
        self.appointmentsTable.delegate = self
        self.appointmentsTable.dataSource = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AppointmentsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentCell.self), for: indexPath)
        guard let appointmentCell = cell as? AppointmentCell else { return cell }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU")
        dateFormatter.dateFormat = "d MMM, yyyy"
        let dateString = dateFormatter.string(from: appointments[indexPath.row].date)
        
        if appointments[indexPath.row].date > .now {
            appointmentCell.ViewWithData.backgroundColor = .blue
        } else {
            appointmentCell.ViewWithData.backgroundColor = .systemRed
        }
        
        appointmentCell.appointmentNameLabel.text = appointments[indexPath.row].name
        appointmentCell.appointmentDateLabel.text = dateString
        appointmentCell.appointmentTimeLabel.text = appointments[indexPath.row].time
        appointmentCell.appointmentMasterNameLabel.text = appointments[indexPath.row].masterName
        return appointmentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

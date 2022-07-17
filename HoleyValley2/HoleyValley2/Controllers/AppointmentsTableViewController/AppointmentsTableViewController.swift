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
        
        self.appointments = RealmManager.read(type: AppointmentRealm.self)
        self.appointmentsTable.reloadData()
    }
    
    private func setupTable() {
        
        appointmentsTable.register(UINib(nibName: String(describing: AppointmentCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AppointmentCell.self))
        self.appointmentsTable.delegate = self
        self.appointmentsTable.dataSource = self
    }
}

extension AppointmentsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return appointments.filter ({ $0.date > .now }).count
        }
        
        return appointments.filter ({ $0.date < .now }).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Предстоящие"
        } else {
            return "Архив"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentCell.self), for: indexPath)
        guard let appointmentCell = cell as? AppointmentCell else { return cell }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU")
        dateFormatter.dateFormat = "d MMM, yyyy"
        let dateString = dateFormatter.string(from: appointments[indexPath.row].date)
        
//        if appointments[indexPath.row].date > .now {
//            appointmentCell.ViewWithData.layer.borderColor = UIColor.blue.cgColor
//            appointmentCell.ViewWithData.layer.borderWidth = 1
//        } else {
//            appointmentCell.ViewWithData.layer.borderColor = UIColor.systemRed.cgColor
//            appointmentCell.ViewWithData.layer.borderWidth = 1
//        }
        
        appointmentCell.appointmentNameLabel.text = appointments[indexPath.row].name
        appointmentCell.appointmentPhoneLabel.text = appointments[indexPath.row].phone
        appointmentCell.appointmentDateLabel.text = dateString
        appointmentCell.appointmentTimeLabel.text = appointments[indexPath.row].time
        appointmentCell.appointmentMasterNameLabel.text = appointments[indexPath.row].masterName
        appointmentCell.appointmentNotificationDateAndTimeLabel.text = appointments[indexPath.row].notificationDateAndTime
        return appointmentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            RealmManager.remove(object: self.appointments[indexPath.row])
            self.appointments = RealmManager.read(type: AppointmentRealm.self)
            self.appointmentsTable.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
    }
}

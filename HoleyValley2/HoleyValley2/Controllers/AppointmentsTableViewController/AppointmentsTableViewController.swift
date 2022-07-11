//
//  AppointmentsTableViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 11.07.22.
//

import UIKit

class AppointmentsTableViewController: UIViewController {

    @IBOutlet weak var appointmentsTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupTable()
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
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentCell.self), for: indexPath)
        guard let appointmentCell = cell as? AppointmentCell else { return cell }
        
        return appointmentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

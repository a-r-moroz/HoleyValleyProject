//
//  ServicesViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase

class ServicesViewController: UIViewController {
    
    var database: DatabaseReference!
    var services = [Service]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        services = FirebaseManager.getServices()
    }
    
}

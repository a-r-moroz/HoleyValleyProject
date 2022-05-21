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
    var decorations = [Decoration]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        decorations = FirebaseManager.getDecorations()
    }
}

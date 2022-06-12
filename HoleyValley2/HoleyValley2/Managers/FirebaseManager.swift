//
//  FirebaseManager.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 21.05.22.
//

import Foundation
import Firebase

final class FirebaseManager {
    private static var database: DatabaseReference! = Database.database().reference()
//    database = Database.database().reference()
    
    /*
    static func getDecorations() -> [Decoration] {
        
//        database = Database.database().reference()
        var decorations: [Decoration] = [Decoration]()
            
        let query = self.database.child(Const.Firebase.decorationsPath).queryOrderedByKey()
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let description = value?["describtion"] as? String ?? ""
                let price = value?["price"] as? Int ?? 0
                let type = value?["type"] as? String ?? ""
                let picture = value?["picture"] as? String ?? ""
                
                let item = Decoration(name: name, price: price, description: description, type: type, image: picture)
                
                decorations.append(item)
                print(decorations.count)
            }
        }
        return decorations
    }
    
    static func getServices() -> [Service] {
        
        var services: [Service] = [Service]()
            
        let query = self.database.child(Const.Firebase.servicesPath).queryOrderedByKey()
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let value = child.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let describtion = value?["describtion"] as? String ?? ""
                let price = value?["price"] as? Int ?? 0
                
                let item = Service(name: name, price: price, describtion: describtion)
                
                let item = Service()
                item.name = name
                item.describtion = describtion
                item.price = price

                services.append(item)
                print(services.count)
            }
        }
        return services
    }
     
     */
    
    /*
    static func loadDecorationsNoWork(tableView: UITableView) -> [Decoration] {
        
        var decorations = [Decoration]()
            
        let query = self.database.child(Const.Firebase.decorationsPath).queryOrderedByKey()
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let description = value?["describtion"] as? String ?? ""
                let price = value?["price"] as? Int ?? 0
                let type = value?["type"] as? String ?? ""
                let picture = value?["picture"] as? String ?? ""
                
                let item = Decoration(name: name, price: price, description: description, type: type, image: picture)
                decorations.append(item)
                
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
        return decorations
    }
     */
}

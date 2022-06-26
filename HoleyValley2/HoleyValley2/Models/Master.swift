//
//  Master.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 20.06.22.
//

import Foundation

class Master {
    
    var name: String
    var surname: String
    var experience: String
    var description: String
    var photo: String
    var id: String
    
    internal init(name: String, surname: String, experience: String, description: String, photo: String, id: String) {
        self.name = name
        self.surname = surname
        self.experience = experience
        self.description = description
        self.photo = photo
        self.id = id

    }
}

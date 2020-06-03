//
//  UserModel.swift
//  LinkSAppIOS
//
//  Created by Apple on 20/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class User: CustomStringConvertible {
    
    var id: Int?
    var name: String
    var surname: String
    var email: String
    var password: String?
    var birthdate: String
    var picture: String
    var points: Int
    var gender: Int
    var adresse: String
    var city: String
    var postcode: Int
    var category: String
    var type: String
    
    
    init(id_user: Int, name: String, surname: String, email: String, password: String, birthdate: String, picture: String, points: Int, gender: Int, adresse: String, city: String, postcode: Int, category: String, type: String) {
        self.id=id_user
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.birthdate = birthdate
        self.picture = picture
        self.points = points
        self.gender = gender
        self.adresse = adresse
        self.city = city
        self.postcode = postcode
        self.category = category
        self.type = type
        
        
    }
    
    var description: String {
        return "{\"email\": \"\(self.email)\", \"password\":\"\(self.password!)\", \"name\":\"\(self.name)\", \"surname\":\"\(self.surname)\", \"birthdate\":\"\(self.birthdate)\", \"picture\":\"\(self.picture)\",\"points\":\"\(self.points)\",\"gender\":\"\(self.gender)\",\"adress\":\"\(self.adresse)\",\"city\":\"\(self.city)\",\"postcode\":\"\(self.postcode)\",\"category\":\"\(self.category)\",\"type\":\"\(self.type)\"}"
    }
    
}

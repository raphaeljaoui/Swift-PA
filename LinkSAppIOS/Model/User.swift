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
    var picture: String?
    var points: Int
    var gender: Int?
    var adress: String?
    var city: String?
    var postcode: Int?
    var category: String?
    var type: String
    
    
    init(id_user: Int, name: String, surname: String, email: String, birthdate: String, points: Int, type: String) {
        self.id = id_user
        self.name = name
        self.surname = surname
        self.email = email
        self.birthdate = birthdate
        self.points = points
        self.type = type
    }
    
    var description: String {
        return "{\"email\": \"\(self.email)\", \"password\":\"\(self.password  ?? "")\", \"name\":\"\(self.name)\", \"surname\":\"\(self.surname)\", \"birthdate\":\"\(self.birthdate)\", \"picture\":\"\(self.picture ?? "")\",\"points\":\"\(self.points)\",\"gender\":\"\(self.gender ?? 0)\",\"adress\":\"\(self.adress ?? "")\",\"city\":\"\(self.city ?? "")\",\"postcode\":\"\(self.postcode ?? 0)\",\"category\":\"\(self.category ?? "")\",\"type\":\"\(self.type)\"}"
    }
    
}

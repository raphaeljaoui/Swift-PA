//
//  UserFactory.swift
//  LinkSAppIOS
//
//  Created by Apple on 20/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class UserFactory {
    
    static func userFrom(dictionary: [String: Any]) -> User? {
        guard let id = dictionary["id"] as? Int,
            let email = dictionary["email"] as? String,
            let name = dictionary["name"] as? String,
            let surname = dictionary["surname"] as? String,
            let birthdate = dictionary["birthdate"] as? String,
            let points = dictionary["points"] as? Int,
            let type = dictionary["type"] as? String else {
                return nil
        }
        let user = User(id_user: id, name: name, surname: surname, email: email, birthdate: birthdate, points: points, type: type)
        
        user.adress = dictionary["adress"] as? String
        user.city = dictionary["city"] as? String
        user.postcode = dictionary["postcode"] as? Int
        user.active = dictionary["active"] as? Int
        
        
        
        return user
    }
    
    static func dictionaryFrom(user: User) -> [String: Any] {
        return [
            "email" : user.email,
            "name" : user.name,
            "surname" : user.surname,
            "birthdate" : user.birthdate,
            "points" : user.points,
            "type" : user.type,
            "password" : user.password ?? "",
            "adress" : user.adress ?? "",
            "city" : user.city ?? "",
            "postcode" : user.postcode ?? "",
            "active" : user.active ?? "",
            
        ]
    }
}

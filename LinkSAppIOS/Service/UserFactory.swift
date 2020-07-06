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
        let login = User(id_user: id, name: name, surname: surname, email: email, birthdate: birthdate, points: points, type: type)
//        login.id = dictionary["id"] as? Int
        return login
    }
    
    static func dictionaryFrom(login: UserLogin) -> [String: Any] {
        return [
            "table": login.table,
            "values": ["email" : login.values?.email as Any ,
                       "password" : login.values?.password as Any,
            ],
        ]
    }
}

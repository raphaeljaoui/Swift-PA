//
//  UserLoginFactory.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 04/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class UserLoginFactory {
    
    static func userFrom(dictionary: [String: Any]) -> UserLogin? {
        guard let table = dictionary["table"] as? String,
            let values = dictionary["values"] as? Login else {
                return nil
        }
        let login = UserLogin(table: table, values: values)
//        login.id = dictionary["id"] as? Int
        return login
    }
    
    static func dictionaryFrom(login: UserLogin) -> [String: Any] {
        return ["email" : login.values?.email as Any ,
                "password" : login.values?.password as Any,
        ]
    }
}

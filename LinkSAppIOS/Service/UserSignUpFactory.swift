//
//  UserSignUpFactory.swift
//  LinkSAppIOS
//
//  Created by Apple on 22/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class UserSignUpFactory {
    
    static func userFrom(dictionary: [String: Any]) -> UserSignUp? {
        guard let table = dictionary["table"] as? String,
            let values = dictionary["values"] as? User else {
                return nil
        }
        let signUp = UserSignUp(table: table, values: values)
//        login.id = dictionary["id"] as? Int
        return signUp
    }
    
    static func dictionaryFrom(signUP: UserSignUp) -> [String: Any] {
        return [
            "table": signUP.table,
            "values": signUP.values?.email as Any ,
        ]
    }
}

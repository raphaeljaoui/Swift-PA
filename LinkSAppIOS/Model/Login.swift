//
//  loginModel.swift
//  LinkSAppIOS
//
//  Created by Apple on 20/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class Login: CustomStringConvertible {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var description: String {
        return "{\"email\":\"\(self.email)\", \"password\":\"\(self.password)\"}"
        
    }
    
}

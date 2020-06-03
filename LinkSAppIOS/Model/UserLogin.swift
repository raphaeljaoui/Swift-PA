//
//  UserLogin.swift
//  LinkSAppIOS
//
//  Created by Apple on 20/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation
class UserLogin: CustomStringConvertible {
    
    var table: String
    var values: Login?

    init(table: String, values: Login) {
        self.table = table
        self.values = values
    }

    var description: String {
        return "{\"table\":\"\(self.table)\", \"values\":\(self.values!)}"
    }
}

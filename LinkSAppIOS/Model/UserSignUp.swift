//
//  UserSignUp.swift
//  LinkSAppIOS
//
//  Created by Apple on 22/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation
class UserSignUp: CustomStringConvertible {
    
    var table: String
    var values: User?

    init(table: String, values: User) {
        self.table = table
        self.values = values
    }

    var description: String {
        return "{\"table\":\"\(self.table)\", \"values\":\(self.values!)}"
    }
}

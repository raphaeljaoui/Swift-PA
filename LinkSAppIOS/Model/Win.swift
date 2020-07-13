//
//  Win.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 13/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class Win: CustomStringConvertible {
    var id_user : Int
    var id_badge : Int
    
    init(id_user: Int, id_badge: Int) {
        self.id_user = id_user
        self.id_badge = id_badge
    }
    
    var description: String{
        return "\(self.id_user) \(self.id_badge)"
    }
}

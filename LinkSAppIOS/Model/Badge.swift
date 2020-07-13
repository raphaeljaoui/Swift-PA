//
//  Badge.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 12/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class Badge: CustomStringConvertible{
    
    var id : Int
    var name : String
    var image : String?
    var pointsLimit : Int
    var id_type : Int
    
    init(id: Int, name: String, pointsLimit: Int, id_type: Int) {
        self.id = id
        self.name = name
        self.pointsLimit = pointsLimit
        self.id_type = id_type
    }
    
    var description: String{
        return self.name
    }
}


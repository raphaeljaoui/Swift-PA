//
//  BadgeFactory.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 12/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class BadgeFactory{
    
    static func BadgeFrom(dictionary: [String: Any]) -> Badge? {
        guard let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let pointsLimit = dictionary["pointsLimit"] as? Int,
            let id_type = dictionary["id_type"] as? Int else {
                return nil
        }
        let badge = Badge(id: id, name: name, pointsLimit: pointsLimit, id_type: id_type)
        badge.image = dictionary["image"] as? String

        return badge
    }
    
    static func dictionaryFrom(badge: Badge) -> [String: Any] {
        return [
            "id": badge.id,
            "name": badge.name,
            "image": badge.image,
            "pointsLimit": badge.pointsLimit,
            "id_type": badge.id_type
        ]
    }
}

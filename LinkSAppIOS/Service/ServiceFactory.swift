//
//  ServiceFactory.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 04/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class ServiceFactory {
    
    //Function type to switch Service to dictionnary with right values
    static func serviceFrom(dictionary: [String: Any]) -> Service? {
        guard let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let date = dictionary["date"] as? String,
            let deadline = dictionary["deadline"] as? String,
            let cost = dictionary["cost"] as? Int,
            let profit = dictionary["profit"] as? Int,
            let access = dictionary["access"] as? String,
            let type = dictionary["type"] as? Int,
            let creator = dictionary["creator"] as? Int else {
                return nil
        }
        let service = Service(idService: id, name: name, date: date, deadline: deadline, cost: cost, profit: profit, access: access, type: type, creator: creator)
        
        return service
    }
    
    static func dictionaryFrom(service: Service) -> [String: Any] {
        return [
            "name": service.name,
            "date": service.date,
            "deadline": service.deadline,
            "cost": service.cost,
            "profit": service.profit,
            "access": service.access,
            "id_type": service.id_type,
            "id_creator": service.id_creator,
        ]
    }
    
}

//
//  Service.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 04/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class Service: CustomStringConvertible {
    
    var id: Int
    var name: String
    var desc: String?
    var date: String
    var deadline: String
    var cost: Int
    var profit: Int
    var adress: String?
    var city: String?
    var postcode: Int?
    var access: String
    var id_type: Int
    var id_creator: Int
    var executorUser: Int?
    
    
    init(idService: Int, name: String, date: String, deadline: String, cost: Int, profit: Int, access: String, type: Int, creator: Int){
        self.id = idService;
        self.name = name;
        self.date = date;
        self.deadline = deadline;
        self.cost = cost;
        self.profit = profit;
        self.access = access;
        self.id_type = type;
        self.id_creator = creator;
    }
    
    func getExecutorUser(id: Int) -> User? {
        return nil
    }
    
    var description: String {
        return "{\"name\": \"\(self.name)\"}"
    }
}

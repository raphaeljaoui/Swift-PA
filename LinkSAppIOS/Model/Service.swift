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
    var Statut: Int
    
    
    init(idService: Int, name: String, date: String, deadline: String, cost: Int, profit: Int, access: String, type: Int, creator: Int, Statut: Int){
        self.id = idService;
        self.name = name;
        self.date = String(date.prefix(10));
        self.deadline = String(deadline.prefix(10));
        self.cost = cost;
        self.profit = profit;
        self.access = access;
        self.id_type = type;
        self.id_creator = creator;
        self.Statut = Statut;
    }
    
    var description: String {
        return "{\"id\": \"\(self.id)\", \"name\": \"\(self.name)\", \"date\": \"\(self.date)\", \"deadline\": \"\(self.deadline)\", \"cost\": \"\(self.cost)\", \"profit\": \"\(self.profit)\", \"access\": \"\(self.access)\", \"id_type\": \"\(self.id_type)\", \"id_creator\": \"\(self.id_creator)\",}"
    }
}

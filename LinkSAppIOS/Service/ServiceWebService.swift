//
//  ServiceWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 04/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class ServiceWebService {
    
    func setService(service: Service, completion: @escaping (Bool) -> Void) -> Void {
        let url = Config.urlAPI + "/services"
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ServiceFactory.dictionaryFrom(service: service), options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                completion(httpRes.statusCode == 200)
            }
            completion(false)
            
           }
        task.resume()
    }

    func getServices(statutId: Int, completion: @escaping ([Service]) -> Void) -> Void {
        let url = Config.urlAPI + "/services/statut/\(statutId)"
        
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, res, err) in
            guard let bytes = data,
            err == nil,
                let json = try? JSONSerialization.jsonObject(with: bytes) as? [Any] else {
                DispatchQueue.main.sync{
                    completion([])
                }
                return
            }
            let services = json.compactMap{(obj) -> Service? in
                guard let dict = obj as? [String :Any] else { return nil }
                return ServiceFactory.serviceFrom(dictionary: dict)
            }
            DispatchQueue.main.sync{
                completion(services)
            }
        }
        task.resume()
        
    }
    
    func getServicesByTypeService(id_type: Int, id_statut: Int, completion: @escaping ([Service]) -> Void) -> Void {
        let url = Config.urlAPI + "/services/actif/\(id_type)&\(id_statut)"
        
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, res, err) in
            guard let bytes = data,
            err == nil,
                let json = try? JSONSerialization.jsonObject(with: bytes) as? [Any] else {
                DispatchQueue.main.sync{
                    completion([])
                }
                return
            }
            let services = json.compactMap{(obj) -> Service? in
                guard let dict = obj as? [String :Any] else { return nil }
                return ServiceFactory.serviceFrom(dictionary: dict)
            }
            DispatchQueue.main.sync{
                completion(services)
            }
        }
        task.resume()
        
    }
    
    func getMyServices(userId: Int, completion: @escaping ([Service]) -> Void) -> Void {
        let url = Config.urlAPI + "/services/creator/\(userId)"
        
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, res, err) in
            guard let bytes = data,
            err == nil,
                let json = try? JSONSerialization.jsonObject(with: bytes) as? [Any] else {
                DispatchQueue.main.sync{
                    completion([])
                }
                return
            }
            let services = json.compactMap{(obj) -> Service? in
                guard let dict = obj as? [String :Any] else { return nil }
                return ServiceFactory.serviceFrom(dictionary: dict)
            }
            DispatchQueue.main.sync{
                completion(services)
            }
        }
        task.resume()
        
    }
    
    func getMyAppliances(userId: Int, completion: @escaping ([Service]) -> Void) -> Void {
        let url = Config.urlAPI + "/apply/\(userId)"
        
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, res, err) in
            guard let bytes = data,
            err == nil,
                let json = try? JSONSerialization.jsonObject(with: bytes) as? [Any] else {
                DispatchQueue.main.sync{
                    completion([])
                }
                return
            }
            let services = json.compactMap{(obj) -> Service? in
                guard let dict = obj as? [String :Any] else { return nil }
                return ServiceFactory.serviceFrom(dictionary: dict)
            }
            DispatchQueue.main.sync{
                completion(services)
            }
        }
        task.resume()
    }
    
    func updateService(service: Service, completion: @escaping (Bool) -> Void) -> Void {
        let url = Config.urlAPI + "/services/\(service.id)"
        
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "PATCH"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ServiceFactory.dictionaryFrom(service: service), options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                completion(httpRes.statusCode == 200)
            }
            completion(false)
            
           }
        task.resume()
    }
    
    
}

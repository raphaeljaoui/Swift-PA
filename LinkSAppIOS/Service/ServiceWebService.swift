//
//  ServiceWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 04/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class ServiceWebService {
    
    /*func getExecutorIfExist(service: Service, completion: @escaping ([User]) -> Void) -> Void {
            guard let urlApi  = URL(string: "http://localhost:4000/services/executor") else {
                return;
            }
            var request = URLRequest(url: urlApi)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: ServiceFactory.dictionaryFrom(service: service), options: .fragmentsAllowed)
            
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
                let executor = json.compactMap{(obj) -> User? in
                    guard let dict = obj as? [String :Any] else { return nil }
                    return UserFactory.userFrom(dictionary: dict)
                }
                DispatchQueue.main.sync{
                    completion(executor)
                }
            }
            task.resume()
        }*/

    func getServices(completion: @escaping ([Service]) -> Void) -> Void {
        guard let urlApi  = URL(string: "http://localhost:4000/services") else {
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
        guard let urlApi  = URL(string: "http://localhost:4000/services/creator/\(userId)") else {
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
        guard let urlApi  = URL(string: "http://localhost:4000/apply/\(userId)") else {
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
    
}

//
//  TypeServiceWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 05/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class TypeServiceWebService{
    
        func getTypesService(completion: @escaping ([TypeService]) -> Void) -> Void {
            let url = Config.urlAPI + "/typeService/active"
            guard let urlApi  = URL(string: url) else {
                return;
            }
            var request = URLRequest(url: urlApi)
            request.httpMethod = "GET"
            
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            guard let bytes = data,
                         err == nil,
                let json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [Any] else {
                           DispatchQueue.main.sync {
                            
                               completion([])
                           }
                       return
                   }
                let types = json.compactMap { (obj) -> TypeService? in
                    guard let dict = obj as? [String: Any] else {
                        return nil
                    }
                    
                    return TypeServiceFactory.TypeServiceFrom(dictionary: dict)
                }
                DispatchQueue.main.sync {
                    completion(types)
                }
                
               }
            task.resume()
        }
    
    func getTypesServiceById(idType: Int, completion: @escaping ([TypeService]) -> Void) -> Void {
        let url = Config.urlAPI + "/typeService/\(idType)"
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
        guard let bytes = data,
                     err == nil,
            let json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [Any] else {
                       DispatchQueue.main.sync {
                        
                           completion([])
                       }
                   return
               }
            let types = json.compactMap { (obj) -> TypeService? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                
                return TypeServiceFactory.TypeServiceFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(types)
            }
            
           }
        task.resume()
    }
}

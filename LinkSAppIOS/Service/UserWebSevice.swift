////
////  UserWebSevice.swift
////  LinkSAppIOS
////
////  Created by Apple on 20/05/2020.
////  Copyright © 2020 imane. All rights reserved.
////
//
import Foundation

class UserWebService {
    
    func connexionUser(email: String, password: String, completion: @escaping ([User]) -> Void) -> Void {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
            guard let urlApi  = URL(string: "http://localhost:4000/connection/user") else {
                return;
            }
            var request = URLRequest(url: urlApi)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            
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
                let user = json.compactMap { (obj) -> User? in
                    guard let dict = obj as? [String: Any] else {
                        return nil
                    }
                    return UserFactory.userFrom(dictionary: dict)
                }
                DispatchQueue.main.sync {
                    completion(user)
                }
                
               }
            task.resume()
        }
    
    
    func getUserById(idUser: Int, completion: @escaping ([User]) -> Void) -> Void {
        
        guard let urlApi  = URL(string: "http://localhost:4000/user/\(idUser)") else {
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
            let user = json.compactMap { (obj) -> User? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                return UserFactory.userFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(user)
            }
            
           }
        task.resume()
    }
    
      func logUser(signUp: UserSignUp, completion: @escaping (Bool) -> Void) -> Void {
              guard let loginURL = URL(string: "http://localhost:4000/create") else {
                  return
              }
              var request = URLRequest(url: loginURL)
              request.httpMethod = "POST"
              request.httpBody = try? JSONSerialization.data(withJSONObject: UserSignUpFactory.dictionaryFrom(signUP: signUp), options: .fragmentsAllowed)
              request.setValue("application/json", forHTTPHeaderField: "content-type")
              let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
                  if let httpRes = res as? HTTPURLResponse {
                      completion(httpRes.statusCode == 201)
                      return
                  }
                  completion(false)
              })
              task.resume()
          }
    
}

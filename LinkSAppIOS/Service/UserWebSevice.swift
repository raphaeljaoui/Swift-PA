////
////  UserWebSevice.swift
////  LinkSAppIOS
////
////  Created by Apple on 20/05/2020.
////  Copyright © 2020 imane. All rights reserved.
////
//
import Foundation
//
//class UserWebService {
//    func getUser(completion: @escaping ([UserLogin]) -> Void) -> Void {
//        guard let userURL = URL(string: "http://localhost:4000/connection") else {
//            return;
//        }
//        let task = URLSession.shared.dataTask(with: userURL, completionHandler: { (data: Data?, res, err) in
//            guard let bytes = data,
//                  err == nil,
//                let json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [String: Any] else {
//                    DispatchQueue.main.sync {
//                        completion([])
//                    }
//                return
//            }
//            print(json)
//
//            let scooters = json.compactMap { (obj) -> UserLogin? in
//                guard let dict = obj as? [String: Any] else {
//                    return nil
//                }
//                print(dict)
//                return UserFactory.userFrom(dictionary: dict)
//            }
//            DispatchQueue.main.sync {
//                completion(scooters)
//            }
//        })
//        task.resume()
//    }
//
//    func logUser(login: UserLogin, completion: @escaping (Bool) -> Void) -> Void {
//          guard let loginURL = URL(string: "http://localhost:4000/connection") else {
//              return
//          }
//          var request = URLRequest(url: loginURL)
//          request.httpMethod = "POST"
//          request.httpBody = try? JSONSerialization.data(withJSONObject: UserFactory.dictionaryFrom(login: login), options: .fragmentsAllowed)
//          request.setValue("application/json", forHTTPHeaderField: "content-type")
//          let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
//              if let httpRes = res as? HTTPURLResponse {
//                  completion(httpRes.statusCode == 201)
//                  return
//              }
//              completion(false)
//          })
//          task.resume()
//      }
//}

class UserWebService {
    
        func connexionUser(login: UserLogin, completion: @escaping ([UserLogin]) -> Void) -> Void {
            guard let urlApi  = URL(string: "http://localhost:4000/connection") else {
                return;
            }
            var request = URLRequest(url: urlApi)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: UserFactory.dictionaryFrom(login: login), options: .fragmentsAllowed)
            
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
                let locations = json.compactMap{(obj) -> UserLogin? in
                    guard let dict = obj as? [String :Any] else { return nil }
                    return UserFactory.userFrom(dictionary: dict)
                }
                DispatchQueue.main.sync{
                    completion(locations)
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

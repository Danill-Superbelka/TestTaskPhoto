//
//  APIManager.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    func getData<Model: Decodable>(request: URLRequest, completion : @escaping (Model?) -> ()) {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let data = data, let decodedData = try? JSONDecoder().decode(Model.self, from: data){
                    completion(decodedData)
                } else {
                    completion([] as? Model)
                }
            }
            dataTask.resume()
        }
    
//    func getUsers(completion: @escaping (Users) -> Void ) {
//        let request = ApiType.getUsers.request
//        print("ЗАПРОС",request)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data, let users = try? JSONDecoder().decode(Users.self, from: data) {
//                completion(users)
//            } else {
//                completion([])
//            }
//        }
//        task.resume()
//    }
    
}

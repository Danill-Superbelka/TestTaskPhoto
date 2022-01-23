//
//  APIManager.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    var songsURL: URLRequest?
    
    func getData<Model: Decodable>(request: URLRequest, completion : @escaping (Model?) -> ()) {
            let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    if let data = data, let decodedData = try? JSONDecoder().decode(Model.self, from: data){
                        completion(decodedData)
                    } else {
                        completion([] as? Model)
                    }
                }
        })
            dataTask.resume()
        }
}


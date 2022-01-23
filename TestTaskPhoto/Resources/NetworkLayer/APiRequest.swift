//
//  APiRequest.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.
//

import Foundation

enum ApiType {
    case getUsers
    case getAlbums
    case getPhotos
    case getUsersPhoto
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var heders: [String:String] {
        switch self {
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getUsers: return "users"
        case .getAlbums: return "albums"
        case .getPhotos: return "photos"
        case .getUsersPhoto: return ""
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        var request = URLRequest(url:url)
        request.allHTTPHeaderFields = heders
        
        switch self {
        default:
            request.httpMethod = "GET"
            return request
        }
    }
}



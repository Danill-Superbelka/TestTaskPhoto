//
//  Photos.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.
//
// To parse the JSON, add this file to your project and do:
//
//   let photos = try? newJSONDecoder().decode(Photos.self, from: jsonData)

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

typealias Photos = [Photo]

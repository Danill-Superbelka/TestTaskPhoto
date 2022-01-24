//
//  Albums.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.

import Foundation
// MARK: - Album
struct Album: Codable {
    let userID, id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
    }
}

typealias Albums = [Album]

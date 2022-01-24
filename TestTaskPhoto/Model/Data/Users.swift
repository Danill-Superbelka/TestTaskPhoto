//
//  Users.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 21.01.2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let name: String
}

typealias Users = [User]

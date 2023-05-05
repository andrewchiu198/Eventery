//
//  User.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/1/23.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var netid: String
    var email: String
}

struct UserResponse: Codable {
    var users : [User]
}

//
//  User.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/1/23.
//

import Foundation

struct User: Codable {
    var username: String
    var password: String
    var email: String
    var name: String
}

struct UserResponse: Codable {
    var users : [User]
}

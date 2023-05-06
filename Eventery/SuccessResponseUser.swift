//
//  SuccessResponseUser.swift
//  Eventery
//
//  Created by Uma Pulugurtha on 5/6/23.
//

import Foundation

struct SuccessResponseUser: Codable {
    var id: Int
    var email: String
    var name: String
    var netid: String
    var session_token: String
    var session_expiration: String
    var update_token: String
}




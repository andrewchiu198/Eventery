//
//  SuccessResponse.swift
//  Eventery
//
//  Created by Uma Pulugurtha on 5/5/23.
//

import Foundation

struct SuccessResponse: Codable {
    var session_token: String
    var session_expiration: String
    var update_token: String
}

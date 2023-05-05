//
//  SuccessReponse.swift
//  Eventery
//
//  Created by Uma Pulugurtha on 5/5/23.
//

import Foundation


struct Error: Codable {
    var session_token: String
    var session_expiration: String
    var update_token: String
}



//
//  Event.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/1/23.
//

import Foundation

struct Event: Codable {
    var id: Int
    var title: String
    var address: String
    var start: String
    var end: String
    var description: String
    var host: String
    var host_email: String
    var free: Bool
    var category: String
}

struct EventResponse: Codable {
    var events: [Event]
}

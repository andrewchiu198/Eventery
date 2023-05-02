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
    var host: String //remove (encapsulated in user)
    var host_email: String //remove (encapsulated in user
    //add user
    var image: String //rename to imageType
    var free: Bool
    var attendees: [String] //get rid of this
    var tags: [String] // for now we make this a single string (rename to category)
}

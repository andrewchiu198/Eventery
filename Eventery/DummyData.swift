//
//  DummyData.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/1/23.
//

import Foundation

class DummyData {
    static public let events = [
        
        Event(id: 0,
              title: "Cornell vs. Harvard",
              address: "Schoellkopf Field",
              start: "05/26/2023 12:00am",
              end: "05/26/2023 1:00pm",
              description: "Cornell Lacrosse vs. Harvard Lacrosse, Cornell 7-2, Harvard 3-6",
              host: "Big Red Sports",
              host_email: "BigRedSports@cornell.edu",
              image: "SportEvent",
              free: true,
              attendees: [],
              tags: ["Sports"]),
        
        Event(id: 1,
              title: "Spring Heat",
              address: "Bailey Hall",
              start: "05/12/2023 8:00pm",
              end: "05/12/2023 9:00pm",
              description: "Dance Concert, Spring Heat, 5 Cornell dance groups, experience exhilerating performance from Cornell's best dancers!",
              host: "CornellMusic",
              host_email: "CornellMusic@cornell.edu",
              image: "ArtEvent",
              free: true,
              attendees: [],
              tags: ["Art"]),
        
        Event(id: 2,
              title: "Hotel Ezra Cornell (HEC)",
              address: "Statler Hall",
              start: "04/28/2023 9:00am",
              end: "04/30/2023 8:00pm",
              description: "Hotel Ezra Cornell is an annual weekend-long educational conference put on by the students of the Cornell School of Hotel Administration for leaders of the hospitality industry.",
              host: "Nolan School of Hotel Administration",
              host_email: "NSHA@cornell.edu",
              image: "BusinessEvent",
              free: false,
              attendees: [],
              tags: ["Business"]),
        
        Event(id: 3,
              title: "Slope Day",
              address: "Libe Slope",
              start: "05/10/2023 1:00pm",
              end: "05/10/2023 5:00pm",
              description: "Annual Cornell Festival, featuring performance by Coin",
              host: "Cornell Slope Day Committee",
              host_email: "CornellSlopeDayCommittee@cornell.edu",
              image: "SocialEvent",
              free: false,
              attendees: [],
              tags: ["Social"]),
    
        Event(id: 4,
              title: "Cornell vs. Harvard",
              address: "Schoellkopf Field",
              start: "05/26/2023 12:00am",
              end: "05/26/2023 1:00pm",
              description: "Cornell Lacrosse vs. Harvard Lacrosse, Cornell 7-2, Harvard 3-6",
              host: "Big Red Sports",
              host_email: "BigRedSports@cornell.edu",
              image: "SportEvent",
              free: true,
              attendees: [],
              tags: ["Sports"]),
        
        Event(id: 5,
              title: "Spring Heat",
              address: "Bailey Hall",
              start: "05/12/2023 8:00pm",
              end: "05/12/2023 9:00pm",
              description: "Dance Concert, Spring Heat, 5 Cornell dance groups, experience exhilerating performance from Cornell's best dancers!",
              host: "CornellMusic",
              host_email: "CornellMusic@cornell.edu",
              image: "ArtEvent",
              free: true,
              attendees: [],
              tags: ["Art"]),
        
        Event(id: 6,
              title: "Hotel Ezra Cornell (HEC)",
              address: "Statler Hall",
              start: "04/28/2023 9:00am",
              end: "04/30/2023 8:00pm",
              description: "Hotel Ezra Cornell is an annual weekend-long educational conference put on by the students of the Cornell School of Hotel Administration for leaders of the hospitality industry.",
              host: "Nolan School of Hotel Administration",
              host_email: "NSHA@cornell.edu",
              image: "BusinessEvent",
              free: false,
              attendees: [],
              tags: ["Business"]),
        
        Event(id: 7,
              title: "Festival",
              address: "Willard Straight Hall",
              start: "05/10/2023 1:00pm",
              end: "05/10/2023 5:00pm",
              description: "Annual Cornell Festival, featuring performance by Coin",
              host: "Cornell Slope Day Committee",
              host_email: "CornellSlopeDayCommittee@cornell.edu",
              image: "SocialEvent",
              free: false,
              attendees: [],
              tags: ["Social"])
    
    ]
}

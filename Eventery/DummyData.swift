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
              address: "Schoelpkoeff Field",
              start: "05/12/2023 1:00pm",
              end: "05/12/2023 4:00pm",
              description: "Cornell vs. Harvard (Lacrosse) Cornell 6:2, Harvard 2:6",
              host: "BigRedSports",
              host_email: "brc@cornell.edu",
              free: false,
              category: "Sports"),

        Event(id: 1,
              title: "Spring Heat",
              address: "Bailey Hall",
              start: "05/12/2023 8:00pm",
              end: "05/12/2023 9:00pm",
              description: "Dance Concert, Spring Heat, 5 Cornell dance groups, experience exhilerating performance from Cornell's best dancers!",
              host: "CornellMusic",
              host_email: "CornellMusic@cornell.edu",
              free: true,
              category: "Art"),

        Event(id: 2,
              title: "Hotel Ezra Cornell (HEC)",
              address: "Statler Hall",
              start: "04/28/2023 9:00am",
              end: "04/30/2023 8:00pm",
              description: "Hotel Ezra Cornell is an annual weekend-long educational conference put on by the students of the Cornell School of Hotel Administration for leaders of the hospitality industry.",
              host: "Nolan School of Hotel Administration",
              host_email: "NHSA@cornell.edu",
              
              free: false,
              category: "Business"),

        Event(id: 3,
              title: "Slope Day",
              address: "Libe Slope",
              start: "05/10/2023 1:00pm",
              end: "05/10/2023 5:00pm",
              description: "Annual Cornell Festival, featuring performance by Coin",
              host: "Cornell Slope Day Committee",
              host_email: "CornellSlopeDayCommittee@cornll.edu",
              free: false,
              category: "Social"),

        Event(id: 4,
              title: "Cornell vs. Harvard",
              address: "Schoelpkoeff Field",
              start: "05/12/2023 1:00pm",
              end: "05/12/2023 4:00pm",
              description: "Cornell vs. Harvard (Lacrosse) Cornell 6:2, Harvard 2:6",
              host: "BigRedSports",
              host_email: "brc@cornell.edu",
              free: false,
              category: "Sports"),

        Event(id: 5,
              title: "Spring Heat",
              address: "Bailey Hall",
              start: "05/12/2023 8:00pm",
              end: "05/12/2023 9:00pm",
              description: "Dance Concert, Spring Heat, 5 Cornell dance groups, experience exhilerating performance from Cornell's best dancers!",
              host: "CornellMusic",
              host_email: "CornellMusic@cornell.edu",
              
              free: true,
              category: "Art"),

        Event(id: 6,
              title: "Hotel Ezra Cornell (HEC)",
              address: "Statler Hall",
              start: "04/28/2023 9:00am",
              end: "04/30/2023 8:00pm",
              description: "Hotel Ezra Cornell is an annual weekend-long educational conference put on by the students of the Cornell School of Hotel Administration for leaders of the hospitality industry.",
              host: "Nolan School of Hotel Administration",
              host_email: "NHSA@cornell.edu",
              
              free: false,
              category: "Business"),

        Event(id: 7,
              title: "Slope Day",
              address: "Libe Slope",
              start: "05/10/2023 1:00pm",
              end: "05/10/2023 5:00pm",
              description: "Annual Cornell Festival, featuring performance by Coin",
              host: "Cornell Slope Day Committee",
              host_email: "CornellSlopeDayCommittee@cornll.edu",
              free: false,
              category: "Social"),

//im testing the conversion of event objects to locations on the map pls ignore for now
        Event(id: 8,
              title: "Engineering Event",
              address: "166 Hoy Road",
              start: "05/10/2023 1:00pm",
              end: "05/10/2023 5:00pm",
              description: "Engineering Event",
              host: "Engineering Administration",
              host_email: "engineering@cornell.edu",
              free: true,
              category: "Social")
    ]
    
}

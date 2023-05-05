//
//  CalendarDay.swift
//  Eventery
//
//  Created by Quinn Hulme on 5/2/23.
//

import Foundation

class CalendarDay {
    var day: String!
    var month: Month!
    var date: Date!

    enum Month {
        case previous
        case current
        case next
    }
}

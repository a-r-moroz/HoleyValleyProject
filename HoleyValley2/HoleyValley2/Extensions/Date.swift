//
//  Date.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 14.06.22.
//

import Foundation

extension Date {
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {

        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {

        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}

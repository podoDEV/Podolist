//
//  CalendarUtils.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation
import SwiftDate

class CalendarUtils {

    static var today = Date()

    static var calendar = Calendar.autoupdatingCurrent

    static func isPast(date: Date) -> Bool {
        let dateComps = dateComponentsOfDate(date: date)
        let todayComps = dateComponentsOfDate(date: today)
        return dateComps.year! < todayComps.year!
            || dateComps.month! < todayComps.month!
            || dateComps.day! < todayComps.day!
    }

    static func isToday(date: Date) -> Bool {
        let dateComps = dateComponentsOfDate(date: date)
        let todayComps = dateComponentsOfDate(date: today)
        return dateComps.year == todayComps.year
            && dateComps.month == todayComps.month
            && dateComps.day == todayComps.day
    }

    static func isFuture(date: Date) -> Bool {
        let dateComps = dateComponentsOfDate(date: date)
        let todayComps = dateComponentsOfDate(date: today)
        return todayComps.year! < dateComps.year!
            || todayComps.month! < dateComps.month!
            || todayComps.day! < dateComps.day!
    }

    static func dateComponentsOfDate(date: Date) -> DateComponents {
        let comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .weekday, .weekOfMonth], from: date)
        return comps
    }
}

//
//  CalendarUtils.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
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

    static func convertStandardStartDate(date: Date) -> Date {
        var comps = dateComponentsOfDate(date: date)
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        return Date(components: comps, region: Region(fromDateComponents: comps))!
    }

    static func convertStandardEndDate(date: Date) -> Date {
        var comps = dateComponentsOfDate(date: date)
        comps.hour = 23
        comps.minute = 59
        comps.second = 59
        return Date(components: comps, region: Region(fromDateComponents: comps))!
    }
}

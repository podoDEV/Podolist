//
//  DateUtils.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

class DateUtils {

    static let region = Region(calendar: Calendars.gregorian, zone: Zones.current, locale: Locales.current)

    static let todayRegion = DateInRegion(Date(), region: DateUtils.region)
}

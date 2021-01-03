//
//  WCMonthView.swift
//  Podolist
//
//  Copyright © 2019 podo. All rights reserved.
//

import SwiftDate

class WCMonthView: BaseView {

    var weeks = [WCWeekView]()
    var date: DateInRegion? {
        didSet {
            updateWeeks()
        }
    }

    override func setupSubviews() {
        for _ in 0..<6 {
            let week = WCWeekView()
            addSubview(week)
            weeks.append(week)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var y: CGFloat = 0
        for week in weeks {
            week.frame = CGRect(x: 0, y: y, width: bounds.size.width, height: bounds.size.height / CGFloat(weeks.count))
            y = week.frame.maxY
        }
    }

    func updateWeeks() {
        var date = self.date?.dateAt(.startOfWeek)
        for week in weeks {
            week.year = self.date?.year
            week.month = self.date?.month
            week.date = date
            date = date?.dateAt(.nextWeek)
        }
    }
}

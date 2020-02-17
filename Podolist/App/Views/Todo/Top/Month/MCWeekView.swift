//
//  MCWeekView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

class MCWeekView: BaseView {

    var days = [MCDayView]()
    var date: DateInRegion? {
        didSet {
            updateDays()
        }
    }
    var year: Int?
    var month: Int?

    override func setupSubviews() {
        for _ in 0..<7 {
            let day = MCDayView()
            day.backgroundColor = .clear
            addSubview(day)
            days.append(day)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for day in days {
            day.frame = CGRect(x: x, y: 0, width: bounds.size.width / CGFloat(days.count) as CGFloat, height: bounds.size.height)
            x = day.frame.maxX
        }
    }

    func updateDays() {
        var date = self.date!
        for day in days {
            day.isSameMonth = (date.year == self.year && date.month == self.month)
            day.isSunday = date == date.dateAt(.startOfWeek)
            day.date = date
            date = date.dateAt(.tomorrow)
        }
    }
}

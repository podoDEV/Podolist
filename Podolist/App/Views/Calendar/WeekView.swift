//
//  WeekView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftDate

class WeekView: UIView {

    var days = [DayView]()
    var date: DateInRegion? {
        didSet {
            updateDays()
        }
    }
    var month: Int?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        for _ in 0..<7 {
            let day = DayView()
            days.append(day)
            addSubview(day)
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
            day.day = Day(day: date.day)
            day.isSameMonth = (date.month == self.month)
            day.isSelected = false
            day.isToday = date.isToday
            date = date.dateAt(.tomorrow)
        }
    }
}

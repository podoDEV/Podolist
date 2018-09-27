//
//  CalendarView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftDate

class CalendarView: UIScrollView {

    var months = [MonthView]()

    var date: DateInRegion? {
        didSet {
            updateMonths()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        for _ in 0..<3 {
            let month = MonthView()
            months.append(month)
            addSubview(month)
            month.date = DateInRegion().dateAt(.startOfMonth)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for month in months {
            month.frame = CGRect(x: x, y: 0, width: bounds.size.width, height: bounds.size.height)
            x = month.frame.maxX
        }
    }

    func updateMonths() {
        var date = self.date
        for month in months {
            month.date = date
            date = date?.dateAt(.nextMonth)
        }
    }
}

//
//  PodoCalendar.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftDate

class PodoCalendar: UIView {

    lazy var weekLabel: WeekLabelView = {
        let weekLabel = WeekLabelView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 50))
        return weekLabel
    }()

    lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(frame: CGRect(x: 0, y: 50, width: bounds.width, height: bounds.height - 50))
        return calendarView
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        addSubview(weekLabel)
        addSubview(calendarView)
    }
}

extension PodoCalendar: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }
}

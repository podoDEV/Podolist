//
//  MCCalendarView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Core
import SwiftDate

protocol MCCalendarViewDelegate: NSObjectProtocol {
    func calendarView(didSelectDate date: DateInRegion)
}

class MCCalendarView: UIScrollView {

    weak var calDelegate: MCCalendarViewDelegate?

    var months = [MCMonthView]()
    var currentPosition = 1
    var selectedDate: DateInRegion?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        var date = DateInRegion().dateAt(.prevWeek)
        for _ in 0..<3 {
            let month = MCMonthView()
            month.date = date
            addSubview(month)
            months.append(month)
            date = date.dateAt(.nextWeek)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for month in months {
            month.frame = CGRect(x: x, y: 0, width: bounds.size.width, height: bounds.size.height)
            x = month.frame.maxX
        }
        contentSize = CGSize(width: bounds.size.width * CGFloat(months.count), height: bounds.size.height)
    }
}

extension MCCalendarView {

    func update(_ dateInRegion: DateInRegion) {
        var date = dateInRegion.dateAt(.prevMonth)
        for month in months {
            month.date = date
            date = date.dateAt(.nextMonth)
        }
        selectDate(date: dateInRegion)
    }

    func move(to toDirection: Direction) {
        let page1 = months[0]
        let page2 = months[1]
        let page3 = months[2]

        let prevX = page1.frame.origin.x
        let currentX = page2.frame.origin.x
        let nextX = page3.frame.origin.x

        if toDirection == .prev {
            page1.frame.origin.x = currentX
            page2.frame.origin.x = nextX
            page3.frame.origin.x = prevX
            page3.date = page1.date?.dateAt(.prevMonth)
            months = [page3, page1, page2]
            contentOffset.x = frame.width
            let date = selectedDate!.dateByAdding(-1, .month)
            selectDate(date: date)
            calDelegate?.calendarView(didSelectDate: date)
        }

        if toDirection == .next {
            page1.frame.origin.x = nextX
            page2.frame.origin.x = prevX
            page3.frame.origin.x = currentX
            page1.date = page3.date?.dateAt(.nextMonth)
            months = [page2, page3, page1]
            contentOffset.x = frame.width
            let date = selectedDate!.dateByAdding(1, .month)
            selectDate(date: date)
            calDelegate?.calendarView(didSelectDate: date)
        }
    }

    private func selectDate(date: DateInRegion) {
        selectedDate = date
        let selectedDateComps = CalendarUtils.dateComponentsOfDate(date: date.date)
        for month in months {
            for week in month.weeks {
                for day in week.days {
                    if let date = day.date,
                        date.year == selectedDateComps.year,
                        date.month == selectedDateComps.month,
                        date.day == selectedDateComps.day {
                        day.isSelected = true
                    } else {
                        day.isSelected = false
                    }
                }
            }
        }
    }

    internal enum Direction: Int {
        case prev = 0
        case next = 2
    }
}

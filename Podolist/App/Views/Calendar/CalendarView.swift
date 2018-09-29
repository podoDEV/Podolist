//
//  CalendarView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftDate

class CalendarView: UIScrollView {

    var months = [MonthView]()
    var currentPosition = 1
    var selectedDate: DateInRegion?
    var loadedMonthsWidth: CGFloat {
        get {
            return bounds.size.width * CGFloat(months.count)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupObserver()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupObserver()
    }

    func setup() {
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        var date = DateInRegion().dateAt(.prevMonth)
        for _ in 0..<3 {
            let month = MonthView()
            month.date = date
            addSubview(month)
            months.append(month)
            date = date.dateAt(.nextMonth)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for month in months {
            month.frame = CGRect(x: x, y: 0, width: bounds.size.width, height: bounds.size.height)
            x = month.frame.maxX
        }
        contentSize = CGSize(width: loadedMonthsWidth, height: bounds.size.height)
    }

    func setupObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onSelected(notification:)),
                                               name: .dateDidSelected,
                                               object: nil)
    }

    @objc func onSelected(notification: NSNotification) {
        if let date = notification.object as? DateInRegion {
            selectDate(date: date)
        }
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
        }

        if toDirection == .next {
            page1.frame.origin.x = nextX
            page2.frame.origin.x = prevX
            page3.frame.origin.x = currentX
            page1.date = page3.date?.dateAt(.nextMonth)
            months = [page2, page3, page1]
            contentOffset.x = frame.width
        }
        selectDate(date: selectedDate!)
    }

    func selectDate(date: DateInRegion) {
        selectedDate = date
        for month in months {
            for week in month.weeks {
                for day in week.days {
                    if let date = day.date, date.year == selectedDate?.year, date.month == selectedDate!.month, date.day == selectedDate!.day {
                        day.isSelected = true
                    } else {
                        day.isSelected = false
                    }
                }
            }
        }
    }
}

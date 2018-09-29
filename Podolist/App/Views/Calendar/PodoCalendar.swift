//
//  PodoCalendar.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftDate

class PodoCalendar: UIView {

    public var normalDayBackgroundColor: UIColor? {
        didSet {
            if let normalDayBackgroundColor = normalDayBackgroundColor {
                UIColor.normalDayBackgroundColor = normalDayBackgroundColor
            }
        }
    }

    public var selectedDayBackgroundColor: UIColor? {
        didSet {
            if let selectedDayBackgroundColor = selectedDayBackgroundColor {
                UIColor.selectedDayBackgroundColor = selectedDayBackgroundColor
            }
        }
    }

    public var todayBackgroundColor: UIColor? {
        didSet {
            if let todayBackgroundColor = todayBackgroundColor {
                UIColor.todayBackgroundColor = todayBackgroundColor
            }
        }
    }

    public var normalDayTextColor: UIColor? {
        didSet {
            if let normalDayTextColor = normalDayTextColor {
                UIColor.normalDayTextColor = normalDayTextColor
            }
        }
    }

    public var selectedDayTextColor: UIColor? {
        didSet {
            if let selectedDayTextColor = selectedDayTextColor {
                UIColor.selectedDayTextColor = selectedDayTextColor
            }
        }
    }

    public var todayTextColor: UIColor? {
        didSet {
            if let todayTextColor = todayTextColor {
                UIColor.todayTextColor = todayTextColor
            }
        }
    }

    public var otherMonthDayTextColor: UIColor? {
        didSet {
            if let otherMonthDayTextColor = otherMonthDayTextColor {
                UIColor.otherMonthDayTextColor = otherMonthDayTextColor
            }
        }
    }

    lazy var weekLabel: WeekLabelView = {
        let view = WeekLabelView()
        view.backgroundColor = .normalDayBackgroundColor
        return view
    }()

    lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.delegate = self
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    func setup() {
        addSubview(weekLabel)
        addSubview(calendarView)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        weekLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height/7)
        calendarView.frame = CGRect(x: 0, y: bounds.height/7, width: bounds.width, height: bounds.height/7 * 6)
        calendarView.contentOffset.x = bounds.width
        calendarView.selectDate(date: DateInRegion().dateAt(.startOfDay))
    }
}

extension PodoCalendar: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = self.calendarView.contentOffset.x / self.calendarView.frame.width
        if position.isNaN {
            return
        }

        if position <= 0.0 || 2.0 <= position {
            calendarView.move(to: Direction(rawValue: Int(position))!)
        }
    }
}

enum Direction: Int {
    case prev = 0
    case next = 2
}

//
//  PodoCalendarView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

class PodoCalendarView: BaseView {

    public weak var delegate: PodoCalendarViewDelegate?

    var date = Date()

    lazy var weekLabel: WeekLabelView = {
        let view = WeekLabelView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.delegate = self
        return view
    }()

    override func setup() {
        addSubview(weekLabel)
        addSubview(calendarView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onSelected(notification:)),
                                               name: .didSelected,
                                               object: nil)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        weekLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 14)
        calendarView.frame = CGRect(x: 0, y: 14, width: bounds.width, height: bounds.height - 14)
        calendarView.contentOffset.x = bounds.width
        calendarView.selectDate(date: DateInRegion())
    }

    @objc private func onSelected(notification: NSNotification) {
        guard let date = notification.object as? DateInRegion else {
            return
        }

        self.date = date.date
        calendarView.selectDate(date: date)
        if let delegate = delegate {
            delegate.calendarView(self, didSelectDate: date.date)
        }
    }

    func update(_ date: Date) {
        self.date = date
        calendarView.update(DateInRegion(date))
    }
}

extension PodoCalendarView: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = self.calendarView.contentOffset.x / self.calendarView.frame.width
        if position.isNaN {
            return
        }

        if position <= 0.0 || 2.0 <= position {
            calendarView.move(to: Direction(rawValue: Int(position))!)
        }
    }
}

protocol PodoCalendarViewDelegate: NSObjectProtocol {
    func calendarView(_ calendarView: PodoCalendarView, didSelectDate date: Date)
}

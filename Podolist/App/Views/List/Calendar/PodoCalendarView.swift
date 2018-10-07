//
//  PodoCalendarView.swift
//  Podolist
//
//  Created by NHNEnt on 08/10/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

class PodoCalendarView: BaseView {

    public weak var delegate: PodoCalendarViewDelegate?

    lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.delegate = self
        return view
    }()

    override func setup() {
        addSubview(calendarView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onSelected(notification:)),
                                               name: .didSelected,
                                               object: nil)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        calendarView.frame = self.bounds
        calendarView.contentOffset.x = bounds.width
        calendarView.selectDate(date: DateInRegion().dateAt(.startOfDay))
    }

    @objc private func onSelected(notification: NSNotification) {
        guard let date = notification.object as? DateInRegion else {
            return
        }

        calendarView.selectDate(date: date)
        if let delegate = delegate {
            delegate.calendarView(self, didSelectDate: date.date)
        }
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

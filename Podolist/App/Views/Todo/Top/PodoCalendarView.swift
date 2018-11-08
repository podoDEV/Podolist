//
//  PodoCalendarView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

protocol PodoCalendarViewDelegate: NSObjectProtocol {
    func calendarView(_ calendarView: PodoCalendarView, didSelectDate date: Date)
}

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
        view.calDelegate = self
        return view
    }()

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .didSelected,
                                                  object: nil)
    }

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
        guard let date = notification.object as? DateInRegion else { return }
        self.date = date.date
        calendarView.selectDate(date: date)
        delegate?.calendarView(self, didSelectDate: date.date)
    }

    // MARK: - external -> PodoCalendarView
    func update(_ date: Date) {
        self.date = date
        calendarView.update(DateInRegion(date))
    }
}

extension PodoCalendarView: UIScrollViewDelegate, CalendarViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = self.calendarView.contentOffset.x / self.calendarView.frame.width
        if position.isNaN { return }
        if position <= 0.0 || 2.0 <= position {
            calendarView.move(to: CalendarView.Direction(rawValue: Int(position))!)
        }
    }

    // MARK: - internal -> PodoCalendarView
    func calendarView(didSelectDate date: DateInRegion) {
        delegate?.calendarView(self, didSelectDate: date.date)
    }
}

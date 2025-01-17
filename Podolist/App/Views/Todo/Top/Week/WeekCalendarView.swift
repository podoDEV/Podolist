//
//  WeekCalendarView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

protocol WeekCalendarViewDelegate: NSObjectProtocol {
    func calendarView(_ calendarView: WeekCalendarView, didSelectDate date: Date)
}

class WeekCalendarView: BaseView {

    public weak var delegate: WeekCalendarViewDelegate?

    var date = Date()

    lazy var weekLabel: WCWeekLabelView = {
        let view = WCWeekLabelView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var calendarView: WCCalendarView = {
        let view = WCCalendarView()
        view.delegate = self
        view.calDelegate = self
        return view
    }()

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .didWeekSelected,
                                                  object: nil)
    }

    override func setupSubviews() {
        calendarView.update(DateInRegion(date))
        addSubview(weekLabel)
        addSubview(calendarView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onSelected(notification:)),
                                               name: .didWeekSelected,
                                               object: nil)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        weekLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 14)
        calendarView.frame = CGRect(x: 0, y: 14, width: bounds.width, height: bounds.height - 14)
        calendarView.contentOffset.x = bounds.width
    }
}

extension WeekCalendarView: UIScrollViewDelegate {

    // MARK: - 직접 선택한 경우
    @objc private func onSelected(notification: NSNotification) {
        guard let date = notification.object as? DateInRegion else { return }
        calendarView.update(date)
        calendarView(didSelectDate: date)
    }

    // MARK: - 스크롤에 의해 바뀐 경우, delegate로 다시 넘어옴.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = self.calendarView.contentOffset.x / self.calendarView.frame.width
        if position.isNaN { return }
        if position <= 0.0 || 2.0 <= position {
            calendarView.move(to: WCCalendarView.Direction(rawValue: Int(position))!)
        }
    }

    // MARK: - 외부에서 날짜를 주입하는 경우, delegate x
    func update(_ date: Date) {
        self.date = date
        calendarView.update(DateInRegion(date))
    }
}

extension WeekCalendarView: WCCalendarViewDelegate {

    func calendarView(didSelectDate date: DateInRegion) {
        self.date = date.date
        delegate?.calendarView(self, didSelectDate: date.date)
    }
}

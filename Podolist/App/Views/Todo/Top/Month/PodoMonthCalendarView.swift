//
//  PodoMonthCalendarView.swift
//  Podolist
//
//  Copyright © 2019 podo. All rights reserved.
//

import SwiftDate

protocol PodoMonthCalendarViewDelegate: NSObjectProtocol {
    func calendarView(_ calendarView: PodoMonthCalendarView, didSelectDate date: Date)
}

class PodoMonthCalendarView: BaseView {

    public weak var delegate: PodoMonthCalendarViewDelegate?

    var date: Date? {
        didSet {
            yearLabel.text = "\(date!.year)"
            monthLabel.text = date!.monthName(.default)
        }
    }
//
//    var normalWeekdayTextColor: UIColor? {
//        didSet {
//            if let normalWeekdayTextColor = normalWeekdayTextColor {
//                UIColor.normalWeekdayTextColor = normalWeekdayTextColor
//            }
//        }
//    }
//    var normalDayTextColor: UIColor? {
//        didSet {
//            if let normalDayTextColor = normalDayTextColor {
//                UIColor.normalDayTextColor = normalDayTextColor
//            }
//        }
//    }
//    var otherMonthWeekdayTextColor: UIColor? {
//        didSet {
//            if let otherMonthWeekdayTextColor = otherMonthWeekdayTextColor {
//                UIColor.otherMonthWeekdayTextColor = otherMonthWeekdayTextColor
//            }
//        }
//    }
//    var otherMonthDayTextColor: UIColor? {
//        didSet {
//            if let otherMonthDayTextColor = otherMonthDayTextColor {
//                UIColor.otherMonthDayTextColor = otherMonthDayTextColor
//            }
//        }
//    }

    lazy var titleView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var yearLabel: UILabel = {
        let view = UILabel()
        view.font = .appFontM(size: 20)
        view.textColor = .white
        view.backgroundColor = .clear
        return view
    }()

    lazy var monthLabel: UILabel = {
        let view = UILabel()
        view.font = .appFontM(size: 14)
        view.textColor = .white
        view.backgroundColor = .clear
        return view
    }()

    lazy var weekLabel: WeekLabelView = {
        let view = WeekLabelView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 208, green: 208, blue: 208, alpha: 1)
        return view
    }()

    lazy var calendarView: MonthCalendarView = {
        let view = MonthCalendarView()
        view.delegate = self
        view.calDelegate = self
        view.backgroundColor = .clear
        return view
    }()

    lazy var navigateView: CalendarNavigateView = {
        let view = CalendarNavigateView()
        view.backgroundColor = .clear
        view.delegate = self
        return view
    }()

    let backgroundView = UIImageView()
    let gradient = CAGradientLayer()

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .didSelected,
                                                  object: nil)
    }

    override func setup() {
        date = Date()
        calendarView.update(DateInRegion(self.date!))
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [UIColor.gradationStart.cgColor,
                           UIColor.gradationEnd.cgColor]
        gradient.locations = [0, 1]
        backgroundView.layer.addSublayer(gradient)
        titleView.addSubview(yearLabel)
        titleView.addSubview(monthLabel)
        addSubview(backgroundView)
        addSubview(titleView)
        addSubview(weekLabel)
        addSubview(separateView)
        addSubview(calendarView)
        addSubview(navigateView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onSelected(notification:)),
                                               name: .didSelected,
                                               object: nil)
    }

    override func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }

        titleView.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(50)
            $0.leading.equalTo(16)
        }

        yearLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(24)
        }

        monthLabel.snp.makeConstraints {
            $0.top.equalTo(yearLabel.snp.bottom).offset(6)
            $0.height.equalTo(20)
            $0.leading.bottom.equalToSuperview()
        }

        weekLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        separateView.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.height.equalTo(1)
        }

        calendarView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(240)
        }

        navigateView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.frame
        calendarView.contentOffset.x = bounds.width
    }
}

extension PodoMonthCalendarView: UIScrollViewDelegate, CalendarNavigateViewDelegate {

    // MARK: - 직접 선택한 경우
    @objc private func onSelected(notification: NSNotification) {
        guard let date = notification.object as? DateInRegion else { return }
        calendarView.update(date)
        calendarView(didSelectDate: date)
    }

    // MARK: - 스크롤에 의해 바뀐 경우, delegate로 다시 넘어옴.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = self.calendarView.contentOffset.x / self.calendarView.frame.width
        if position.isNaN { return }
        if position <= 0.0 || 2.0 <= position {
            calendarView.move(to: MonthCalendarView.Direction(rawValue: Int(position))!)
        }
    }

    // MARK: - 외부에서 날짜를 주입하는 경우, delegate x
    func update(_ date: Date) {
        self.date = date
        self.navigateView.update(date)
        calendarView.update(DateInRegion(date))
    }

    // MARK: - CalendarNavigateViewDelegate
    func navigate(to direction: MonthCalendarView.Direction) {
        calendarView.move(to: direction)
    }
}

extension PodoMonthCalendarView: CalendarViewDelegate {

    func calendarView(didSelectDate date: DateInRegion) {
        self.date = date.date
        self.navigateView.update(self.date!)
        delegate?.calendarView(self, didSelectDate: date.date)
    }
}
//
//struct CalendarAppearance {
//    static var normalWeekdayTextColor = UIColor(red: 208, green: 2, blue: 27, alpha: 1)
//    static var normalDayTextColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
//    static var otherMonthWeekdayTextColor = UIColor(red: 208, green: 2, blue: 27, alpha: 0.5)
//    static var otherMonthDayTextColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
//}
//
//extension UIColor {
//    static var normalWeekdayTextColor: UIColor {
//        get { return CalendarAppearance.normalWeekdayTextColor }
//        set { CalendarAppearance.normalWeekdayTextColor = newValue }
//    }
//    static var normalDayTextColor: UIColor {
//        get { return CalendarAppearance.normalDayTextColor }
//        set { CalendarAppearance.normalDayTextColor = newValue }
//    }
//    static var otherMonthWeekdayTextColor: UIColor {
//        get { return CalendarAppearance.otherMonthWeekdayTextColor }
//        set { CalendarAppearance.otherMonthWeekdayTextColor = newValue }
//    }
//    static var otherMonthDayTextColor: UIColor {
//        get { return CalendarAppearance.otherMonthDayTextColor }
//        set { CalendarAppearance.otherMonthDayTextColor = newValue }
//    }
//}

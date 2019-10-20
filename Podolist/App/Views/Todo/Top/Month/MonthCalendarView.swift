//
//  MonthCalendarView.swift
//  Podolist
//
//  Copyright © 2019 podo. All rights reserved.
//

import SwiftDate

protocol MonthCalendarViewDelegate: NSObjectProtocol {
    func calendarView(_ calendarView: MonthCalendarView, didSelectDate date: Date)
}

class MonthCalendarView: BaseView {

    public weak var delegate: MonthCalendarViewDelegate?

    var date: Date? {
        didSet {
            yearLabel.text = "\(date!.year)"
            monthLabel.text = date!.monthName(.default)
        }
    }

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

    lazy var weekLabel: MCWeekLabelView = {
        let view = MCWeekLabelView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 208, green: 208, blue: 208, alpha: 1)
        return view
    }()

    lazy var calendarView: MCCalendarView = {
        let view = MCCalendarView()
        view.delegate = self
        view.calDelegate = self
        view.backgroundColor = .clear
        return view
    }()

    lazy var navigateView: MCNavigateView = {
        let view = MCNavigateView()
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

    override func setupSubviews() {
        date = Date()
        calendarView.update(DateInRegion(self.date!))
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [UIColor(red: 106, green: 3, blue: 152, alpha: 1).cgColor,
                           UIColor(red: 85, green: 0, blue: 159, alpha: 1).cgColor]
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

extension MonthCalendarView: UIScrollViewDelegate, MCNavigateViewDelegate {

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
            calendarView.move(to: MCCalendarView.Direction(rawValue: Int(position))!)
        }
    }

    // MARK: - 외부에서 날짜를 주입하는 경우, delegate x
    func update(_ date: Date) {
        self.date = date
        self.navigateView.update(date)
        calendarView.update(DateInRegion(date))
    }

    // MARK: - CalendarNavigateViewDelegate
    func navigate(to direction: MCCalendarView.Direction) {
        calendarView.move(to: direction)
    }
}

extension MonthCalendarView: MCCalendarViewDelegate {

    func calendarView(didSelectDate date: DateInRegion) {
        self.date = date.date
        self.navigateView.update(self.date!)
        delegate?.calendarView(self, didSelectDate: date.date)
    }
}

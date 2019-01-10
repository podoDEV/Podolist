//
//  MainTopView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SnapKit

protocol MainTopViewDelegate: class {
    func didTappedSetting()
    func didTappedMonthCalendar()
    func didSelectDate(date: Date)
}

class MainTopView: BaseView {

    weak var delegate: MainTopViewDelegate?

    let backgroundView = UIImageView()
    let settingButton = UIButton()
    let titleView = UIView()
    let monthLabel = UILabel()
    let yearLabel = UILabel()
    let dropdownView = UIImageView()
    let calendarView = WeekCalendarView()
    let gradient = CAGradientLayer()

    var date: Date? {
        didSet {
            yearLabel.text = "\(date!.year)"
            monthLabel.text = date?.monthName(.default)
        }
    }

    override func setup() {
        super.setup()

        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [UIColor.gradationStart.cgColor,
                            UIColor.gradationEnd.cgColor]
        gradient.locations = [0, 1]
        backgroundView.layer.addSublayer(gradient)
        addSubview(backgroundView)

        settingButton.clipsToBounds = true
        settingButton.addTarget(self, action: #selector(didTappedSetting), for: .touchUpInside)
        addSubview(settingButton)

        calendarView.delegate = self
        addSubview(calendarView)
        addSubview(titleView)

        monthLabel.textColor = .white
        monthLabel.font = .appFontM(size: 20)
        titleView.addSubview(monthLabel)

        yearLabel.textColor = .white
        yearLabel.font = .appFontM(size: 18)
        titleView.addSubview(yearLabel)

        dropdownView.image = InterfaceImage.dropdown.normalImage
        titleView.addSubview(dropdownView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedMonthCalendar))
        titleView.addGestureRecognizer(tap)

        date = calendarView.date
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.frame
        backgroundView.frame = self.frame

        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        settingButton.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -16).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
        settingButton.widthAnchor.constraint(equalTo: settingButton.heightAnchor).isActive = true
        settingButton.layer.cornerRadius = 12

        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -16).isActive = true
        titleView.heightAnchor.constraint(equalTo: monthLabel.heightAnchor).isActive = true

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: self.titleView.topAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: self.titleView.leadingAnchor).isActive = true

        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: self.monthLabel.trailingAnchor, constant: 10).isActive = true

        dropdownView.translatesAutoresizingMaskIntoConstraints = false
        dropdownView.centerYAnchor.constraint(equalTo: self.yearLabel.centerYAnchor).isActive = true
        dropdownView.leadingAnchor.constraint(equalTo: self.yearLabel.trailingAnchor, constant: 10).isActive = true
        dropdownView.trailingAnchor.constraint(equalTo: self.titleView.trailingAnchor).isActive = true

        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    func update(_ date: Date) {
        self.date = date
        calendarView.update(date)
    }

    func updateProfile(_ account: Account) {
        settingButton.setImage(account.profile, for: .normal)
    }

    @objc func didTappedSetting() {
        delegate?.didTappedSetting()
    }

    @objc func didTappedMonthCalendar() {
        delegate?.didTappedMonthCalendar()
    }
}

extension MainTopView: WeekCalendarViewDelegate {

    func calendarView(_ calendarView: WeekCalendarView, didSelectDate date: Date) {
        self.date = date
        delegate?.didSelectDate(date: date)
    }
}

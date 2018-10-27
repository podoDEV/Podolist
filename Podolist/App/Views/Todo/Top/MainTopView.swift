//
//  MainTopView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

protocol MainTopViewDelegate: class {
    func didTappedSetting()
    func didSelectDate(date: Date)
}

class MainTopView: BaseView {

    weak var delegate: MainTopViewDelegate?

    let backgroundView = UIImageView()
    let settingButton = UIButton()
    let titleView = UIView()
    let titleLabel = UILabel()
    let dropdownView = UIImageView()
    let calendarView = PodoCalendarView()
    let gradient = CAGradientLayer()

    var date: Date? {
        didSet {
            titleLabel.text = date?.monthName(.default)
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

        // MARK: - 설정화면 enable
        settingButton.setImage(InterfaceImage.setting.image(.normal), for: .normal)
        settingButton.addTarget(self, action: #selector(didTappedSetting), for: .touchUpInside)
        addSubview(settingButton)

        calendarView.delegate = self
        addSubview(calendarView)
        addSubview(titleView)

        titleLabel.textColor = .white
        titleLabel.font = .appFontM(size: 20)
        titleView.addSubview(titleLabel)

        // MARK: - dropdown enable
//        dropdownView.image = InterfaceImage.dropdown.normalImage
        titleView.addSubview(dropdownView)

        date = calendarView.date
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.frame
        backgroundView.frame = self.frame

        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        settingButton.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -16).isActive = true

        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -16).isActive = true
        titleView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.titleView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.titleView.leadingAnchor).isActive = true

        dropdownView.translatesAutoresizingMaskIntoConstraints = false
        dropdownView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
        dropdownView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10).isActive = true
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

    @objc func didTappedSetting() {
        delegate?.didTappedSetting()
    }
}

extension MainTopView: PodoCalendarViewDelegate {

    func calendarView(_ calendarView: PodoCalendarView, didSelectDate date: Date) {
        self.date = date
        delegate?.didSelectDate(date: date.date)
    }
}

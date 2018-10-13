//
//  MainTopView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

protocol MainTopViewDelegate: class {
    func didSelectDate(date: Date)
}

class MainTopView: BaseView {

    weak var delegate: MainTopViewDelegate?

    let backgroundView = UIImageView()
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

        calendarView.delegate = self
        addSubview(calendarView)
        addSubview(titleView)

        titleLabel.textColor = .white
        titleLabel.font = UIFont.appFontB(size: 20)
        titleView.addSubview(titleLabel)

//        dropdownView.image = InterfaceImage.dropdown.normalImage
        titleView.addSubview(dropdownView)

        date = calendarView.date
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.frame
        backgroundView.frame = self.frame

        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -4).isActive = true
        titleView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.titleView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.titleView.leadingAnchor).isActive = true

        dropdownView.translatesAutoresizingMaskIntoConstraints = false
        dropdownView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
        dropdownView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10).isActive = true
        dropdownView.trailingAnchor.constraint(equalTo: self.titleView.trailingAnchor).isActive = true
    }
}

extension MainTopView: PodoCalendarViewDelegate {
    func calendarView(_ calendarView: PodoCalendarView, didSelectDate date: Date) {
        self.date = date
        if let delegate = delegate {
            delegate.didSelectDate(date: date.date)
        }
    }
}

//
//  MCDayView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

class MCDayView: BaseView {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.appFontM(size: 13)
        return label
    }()

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()

    var date: DateInRegion? {
        didSet {
            self.dateLabel.text = "\((date?.day)!)"
            updateUI()
        }
    }

    var isSameMonth: Bool = true
    var isSunday: Bool = false
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                updateSelectUI()
            } else {
                updateUI()
            }
        }
    }

    override func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onSelected))
        addGestureRecognizer(tap)
        addSubview(backgroundView)
        backgroundView.addSubview(dateLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupBackgroundView()
    }

    func setupBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
        backgroundView.layer.cornerRadius = 14
        dateLabel.frame = backgroundView.bounds
    }

    func updateUI() {
        if isSameMonth {
            if isSunday {
                dateLabel.textColor = .normalSunday
            } else {
                dateLabel.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            }
            backgroundView.backgroundColor = .clear
        } else {
            if isSunday {
                dateLabel.textColor = .otherMonthSunday
            } else {
                dateLabel.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
            }
            backgroundView.backgroundColor = .clear
        }
    }

    func updateSelectUI() {
        dateLabel.textColor = .appColor1
        backgroundView.backgroundColor = .white
    }

    @objc func onSelected() {
        NotificationCenter.default.post(name: .didSelected, object: self.date)
    }
}

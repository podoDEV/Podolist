//
//  WCDayView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

class WCDayView: BaseView {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.appFontB(size: 14)
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
        }
    }

    var isSameMonth: Bool = true {
        didSet {
            updateUI()
        }
    }

    var isSelected: Bool = false {
        didSet {
            if isSelected {
                updateSelectUI()
            } else {
                updateUI()
            }
        }
    }

    override func setupSubviews() {
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
        dateLabel.textColor = .white
        backgroundView.backgroundColor = .clear
    }

    func updateSelectUI() {
        dateLabel.textColor = .appColor1
        backgroundView.backgroundColor = .white
    }

    @objc func onSelected() {
        NotificationCenter.default.post(name: .didWeekSelected, object: self.date)
    }
}

extension NSNotification.Name {
    static let didMonthSelected = Notification.Name("did_selected_month_date")
    static let didWeekSelected = Notification.Name("did_selected_week_date")
}

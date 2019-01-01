//
//  CalendarNavigateView.swift
//  Podolist
//
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

protocol CalendarNavigateViewDelegate: NSObjectProtocol {
    func navigate(to direction: MonthCalendarView.Direction)
}

class CalendarNavigateView: BaseView {

    weak var delegate: CalendarNavigateViewDelegate?

    lazy var prevButton: UIButton = {
        var view = UIButton()
        view.setImage(UIImage(named: "ic_prevMonth"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .appFontL(size: 14)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        view.addTarget(self, action: #selector(didTappedNavigator(_:)), for: .touchUpInside)
        return view
    }()

    lazy var nextButton: UIButton = {
        var view = UIButton()
        view.setImage(UIImage(named: "ic_nextMonth"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .appFontL(size: 14)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        view.semanticContentAttribute = .forceRightToLeft
        view.addTarget(self, action: #selector(didTappedNavigator(_:)), for: .touchUpInside)
        return view
    }()

    override func setup() {
        [prevButton, nextButton].forEach(addSubview)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        prevButton.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        nextButton.frame = CGRect(x: frame.maxX - 50, y: 0, width: 50, height: 40)
    }
}

extension CalendarNavigateView {

    @objc func didTappedNavigator(_ sender: UIButton) {
        if sender.isEqual(prevButton) {
            delegate?.navigate(to: .prev)
        } else if sender.isEqual(nextButton) {
            delegate?.navigate(to: .next)
        }
    }
}

extension CalendarNavigateView {

    func update(_ date: Date) {
        let prevMonth = date.dateAt(.prevMonth).monthName(.short)
        prevButton.setTitle(prevMonth, for: .normal)

        let nextMonth = date.dateAt(.nextMonth).monthName(.short)
        nextButton.setTitle(nextMonth, for: .normal)
    }
}

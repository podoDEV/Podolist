//
//  MCNavigateView.swift
//  Podolist
//
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

protocol MCNavigateViewDelegate: NSObjectProtocol {
    func navigate(to direction: MCCalendarView.Direction)
}

class MCNavigateView: BaseView {

    weak var delegate: MCNavigateViewDelegate?

    lazy var prevButton: UIButton = {
        var view = UIButton()
        view.setImage(UIImage(named: "ic_prevMonth" ), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        view.titleLabel?.font = .appFontL(size: 14)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 10, right: 0)
        view.addTarget(self, action: #selector(didTappedNavigator(_:)), for: .touchUpInside)
        return view
    }()

    lazy var nextButton: UIButton = {
        var view = UIButton()
        view.setImage(UIImage(named: "ic_nextMonth"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        view.titleLabel?.font = .appFontL(size: 14)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 12)
        view.semanticContentAttribute = .forceRightToLeft
        view.addTarget(self, action: #selector(didTappedNavigator(_:)), for: .touchUpInside)
        return view
    }()

    override func setupSubviews() {
        [prevButton, nextButton].forEach(addSubview)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        prevButton.frame = CGRect(x: 10, y: 0, width: 50, height: 40)
        nextButton.frame = CGRect(x: frame.maxX - 50 - 10, y: 0, width: 50, height: 40)
    }
}

extension MCNavigateView {

    @objc func didTappedNavigator(_ sender: UIButton) {
        if sender.isEqual(prevButton) {
            delegate?.navigate(to: .prev)
        } else if sender.isEqual(nextButton) {
            delegate?.navigate(to: .next)
        }
    }
}

extension MCNavigateView {

    func update(_ date: Date) {
        let prevMonth = date.dateAt(.prevMonth).monthName(.short)
        prevButton.setTitle(prevMonth, for: .normal)

        let nextMonth = date.dateAt(.nextMonth).monthName(.short)
        nextButton.setTitle(nextMonth, for: .normal)
    }
}

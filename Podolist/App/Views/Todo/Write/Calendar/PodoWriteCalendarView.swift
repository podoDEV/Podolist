//
//  PodoWriteCalendarView.swift
//  Podolist
//
//  Created by hb1love on 2019/10/27.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import PodoCalendar

final class PodoWriteCalendarView: BaseView {

    weak var delegate: WriteViewDelegate?

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "write.date".localized
            titleLabel.textColor = .appColor1
            titleLabel.font = .appFontM(size: 11)
        }
    }
    @IBOutlet weak var calendarView: PodoCalendar! {
        didSet {
            calendarView.delegate = self
            calendarView.layer.cornerRadius = 17.25
            calendarView.clipsToBounds = true
        }
    }

    func update(_ date: Date?) {
        calendarView.update(date ?? Date())
    }
}

extension PodoWriteCalendarView: PodoCalendarDelegate {

    func calendarView(_ calendarView: PodoCalendar, didSelectDate date: Date) {
        delegate?.didChangedDate(date: date)
    }

    func calendarView(_ calendarView: PodoCalendar, startedAt startDate: Date, finishedAt finishDate: Date) {

    }
}

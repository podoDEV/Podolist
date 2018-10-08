//
//  PodoWriteCalendarView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit
import PodoCalendar

class PodoWriteCalendarView: BaseView {

//    weak var delegate: PodoCalendarViewDelegate?

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = InterfaceString.Write.Date
            titleLabel.textColor = .appColor1
            titleLabel.font = .appFontM(size: 11)
        }
    }
    @IBOutlet weak var calendarView: PodoCalendar! {
        didSet {
            calendarView.layer.cornerRadius = 17.25
            calendarView.clipsToBounds = true
        }
    }
}

//extension PodoWriteCalendarView:

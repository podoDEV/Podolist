//
//  PodoWriteCalendarView.swift
//  Podolist
//
//  Created by NHNEnt on 04/10/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit
import PodoCalendar

class PodoWriteCalendarView: BaseView {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = InterfaceString.Write.Date
            titleLabel.textColor = .appColor1
            titleLabel.font = .appFontM(size: 11)
        }
    }
    @IBOutlet weak var calendarView: PodoCalendarView! {
        didSet {
            calendarView.layer.cornerRadius = 17.25
            calendarView.clipsToBounds = true
        }
    }
}

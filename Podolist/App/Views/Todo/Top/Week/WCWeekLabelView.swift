//
//  WCWeekLabelView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

class WCWeekLabelView: BaseView {

    var weekLabels: [WeekLabel] = [WeekLabel(day: NSLocalizedString("SUN", comment: "Sunday")),
                                   WeekLabel(day: NSLocalizedString("MON", comment: "Monday")),
                                   WeekLabel(day: NSLocalizedString("TUE", comment: "Tuesday")),
                                   WeekLabel(day: NSLocalizedString("WED", comment: "Wednesday")),
                                   WeekLabel(day: NSLocalizedString("THU", comment: "Thursday")),
                                   WeekLabel(day: NSLocalizedString("FRI", comment: "Friday")),
                                   WeekLabel(day: NSLocalizedString("SAT", comment: "Saturday"))]

    override func setupSubviews() {
        for label in weekLabels {
            addSubview(label)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for label in weekLabels {
            label.frame = CGRect(x: x, y: 0, width: bounds.size.width / CGFloat(weekLabels.count), height: bounds.height)
            label.textColor = .white
            label.font = .appFontL(size: 13)
            x = label.frame.maxX
        }
    }

    class WeekLabel: UILabel {

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
        }

        init(day: String) {
            super.init(frame: .zero)
            text = day
            textAlignment = .center
        }
    }
}

//
//  DayView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class DayView: UIView {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        self.addSubview(label)
        return label
    }()

    var day: Day? {
        didSet {
            self.dateLabel.text = day?.toString()
        }
    }

    var isSameMonth: Bool? {
        didSet {
            if let isSameMonth = isSameMonth, !isSameMonth {
                self.dateLabel.textColor = .gray
            }
        }
    }

    var isSelected: Bool? {
        didSet {
            if let isSelected = isSelected, isSelected {
                self.dateLabel.backgroundColor = .red
            }
        }
    }

    var isToday: Bool? {
        didSet {
            if let isToday = isToday, isToday {
                self.dateLabel.backgroundColor = .blue
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.frame = bounds
    }
}

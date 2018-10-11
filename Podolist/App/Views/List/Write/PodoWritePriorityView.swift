//
//  PodoWritePriorityView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

class PodoWritePriorityView: BaseView {

    weak var delegate: WriteViewDelegate?

    var priorities: [Priority] = [.urgent, .high, .medium, .low]
    var priorityButtons = [PriorityButton]()

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = InterfaceString.Write.Priority
            titleLabel.textColor = .appColor1
            titleLabel.font = .appFontM(size: 11)
        }
    }

    @IBOutlet weak var priorityView: UIView! {
        didSet {
            priorityView.backgroundColor = .clear
        }
    }

    override func setup() {
        super.setup()
        for priority in priorities {
            let button = PriorityButton(priority: priority)
            if button.priority == .medium {
                button.isSelectedButton = true
            } else {
                button.isSelectedButton = false
            }
            addSubview(button)
            priorityButtons.append(button)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for button in priorityButtons {
            button.frame = CGRect(x: x, y: titleLabel.frame.maxY + 4, width: 64, height: bounds.size.height - titleLabel.frame.height - 4)
            x = button.frame.maxX + 4
        }
    }
}

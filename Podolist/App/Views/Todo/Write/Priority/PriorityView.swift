//
//  PriorityView.swift
//  Podolist
//
//  Created by hb1love on 2019/10/27.
//  Copyright © 2019 podo. All rights reserved.
//

import Core

protocol PriorityViewDelegate: AnyObject {
    func didChangedPriority(priority: Priority)
}

final class PriorityView: BaseView {

    weak var delegate: PriorityViewDelegate?

//    var selectedPriority: Priority?
    var priorities: [Priority] = [.urgent, .high, .medium, .low, .none]
    var priorityButtons = [PriorityButton]()

    override func setupSubviews() {
        for priority in priorities {
            let button = PriorityButton(priority: priority)
            button.addTarget(self, action: #selector(handlePress(sender:)), for: .touchUpInside)
            addSubview(button)
            priorityButtons.append(button)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for button in priorityButtons {
            button.frame = CGRect(x: x, y: 0, width: 64, height: bounds.height)
            x = button.frame.maxX + 4
        }
    }

    func update(_ priority: Priority?) {
        for button in priorityButtons {
            if priority == button.priority {
                button.isSelectedButton = true
            } else {
                button.isSelectedButton = false
            }
        }
    }

    @objc func handlePress(sender: UIButton) {
        for button in priorityButtons {
            if sender.isEqual(button) {
                if button.isSelectedButton {
                    button.isSelectedButton = false
                    delegate?.didChangedPriority(priority: .none)
                } else {
                    button.isSelectedButton = true
                    delegate?.didChangedPriority(priority: button.priority)
                }
            } else {
                button.isSelectedButton = false
            }
        }
    }
}

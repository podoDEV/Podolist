//
//  PodoWritePriorityView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

class PodoWritePriorityView: BaseView {

    weak var delegate: WriteViewDelegate?

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = InterfaceString.Write.Priority
            titleLabel.textColor = .appColor1
            titleLabel.font = .appFontM(size: 11)
        }
    }

    @IBOutlet weak var priorityView: PriorityView! {
        didSet {
            priorityView.backgroundColor = .clear
            priorityView.delegate = self
        }
    }

    func update(_ priority: Priority) {
        // detailButton init
        priorityView.update(priority)
    }
}

extension PodoWritePriorityView: PriorityViewDelegate {

    func didChangedPriority(priority: Priority) {
        delegate?.didChangedPriority(priority: priority)
    }
}

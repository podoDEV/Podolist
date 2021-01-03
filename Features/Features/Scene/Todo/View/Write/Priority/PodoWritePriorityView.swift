//
//  PodoWritePriorityView.swift
//  Podolist
//
//  Created by hb1love on 2019/10/27.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Core

final class PodoWritePriorityView: BaseView {

    weak var delegate: WriteViewDelegate?

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "write.priority".localized
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

    func update(_ priority: Priority?) {
        priorityView.update(priority)
    }
}

extension PodoWritePriorityView: PriorityViewDelegate {

    func didChangedPriority(priority: Priority) {
        delegate?.didChangedPriority(priority: priority)
    }
}

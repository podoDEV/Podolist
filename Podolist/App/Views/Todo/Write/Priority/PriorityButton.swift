//
//  PriorityButton.swift
//  Podolist
//
//  Created by hb1love on 2019/10/27.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class PriorityButton: UIButton {

    var priority: Priority = .medium
    var isSelectedButton: Bool = false {
        didSet {
            updateUI()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    init(priority: Priority) {
        super.init(frame: .zero)
        self.priority = priority
        setupSubviews()
    }

    func setupSubviews() {
        backgroundColor = .backgroundColor2
        setTitle(priority.toString(), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .appFontM(size: 10)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    func updateUI() {
        if isSelectedButton {
            backgroundColor = priority.backgroundColor()
        } else {
            backgroundColor = .backgroundColor2
        }
    }
}

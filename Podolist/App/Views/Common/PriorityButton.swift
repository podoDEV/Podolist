//
//  PriorityButton.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

protocol PriorityButtonDelegate: class {
    func didPressPriorityButton()
}

class PriorityButton: UIButton {

    weak var delegate: PriorityButtonDelegate?
    var priority: Priority = .medium
    var isSelectedButton: Bool = false {
        didSet {
            updateUI()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupAction()
    }

    init(priority: Priority) {
        super.init(frame: .zero)
        self.priority = priority
        setupUI()
        setupAction()
    }

    func setupUI() {
        backgroundColor = .backgroundColor2
        setTitle(priority.toString(), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.appFontM(size: 10)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    func updateUI() {
        guard isSelectedButton else {
            backgroundColor = .backgroundColor2
            return
        }
        backgroundColor = priority.backgroundColor()
    }

    func setupAction() {
        self.addTarget(self, action: #selector(handlePress(sender:)), for: .touchUpInside)
    }

    @objc func handlePress(sender: UIButton) {
        delegate?.didPressPriorityButton()
    }
}

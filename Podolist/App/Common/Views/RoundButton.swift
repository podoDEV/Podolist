//
//  RoundButton.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

protocol RoundButtonDelegate: class {
    func didPressFloatingButton()
}

class RoundButton: UIButton {

    weak var delegate: RoundButtonDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupAction()
    }

    func setupUI() {
        setImage(InterfaceImage.add.image(.normal), for: .normal)
        self.backgroundColor = .appColor
        tintColor = .white
        layer.cornerRadius = frame.width/2
        layer.masksToBounds = true
    }

    func setupAction() {
        self.addTarget(self, action: #selector(handlePress(sender:)), for: .touchUpInside)
    }

    @objc func handlePress(sender: UIButton) {
        delegate?.didPressFloatingButton()
    }
}

//
//  RoundButton.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {
        setImage(InterfaceImage.add.image(.normal), for: .normal)
        self.backgroundColor = .appColor()
        tintColor = .white
        layer.cornerRadius = frame.width/2
        layer.masksToBounds = true
    }
}

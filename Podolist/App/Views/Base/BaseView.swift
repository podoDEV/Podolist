//
//  BaseView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

class BaseView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    func setup() {

    }

    func setupConstraints() {

    }
}

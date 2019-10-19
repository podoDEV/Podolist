//
//  BaseView.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

class BaseView: UIView {

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {}
    func setupConstraints() {}
}

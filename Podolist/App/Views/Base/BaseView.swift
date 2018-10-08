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
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    func setup() {

    }
}

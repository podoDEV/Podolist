//
//  BaseView.swift
//  Podolist
//
//  Created by NHNEnt on 04/10/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

class BaseView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    func setupUI() {

    }
}

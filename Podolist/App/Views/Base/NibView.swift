//
//  NibView.swift
//  Podolist
//
//  Created by NHNEnt on 05/10/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

class NibView: UIView {
    lazy var view: UIView = {
        let view = loadNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupUI()
    }

    init() {
        super.init(frame: .zero)
        xibSetup()
        setupUI()
    }

    func setupUI() {

    }
}

private extension NibView {

    func xibSetup() {
        backgroundColor = .clear
        addSubview(view)
    }
}

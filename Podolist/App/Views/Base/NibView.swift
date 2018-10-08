//
//  NibView.swift
//  Podolist
//
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
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setup()
    }

    init() {
        super.init(frame: .zero)
        xibSetup()
        setup()
    }

    func setup() {

    }
}

private extension NibView {

    func xibSetup() {
        backgroundColor = .clear
        addSubview(view)
    }
}

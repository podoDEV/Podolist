//
//  PodoWriteView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodoWriteView: UIView {

    lazy var titleField: UITextField = {
        let cgRect = CGRect(x: 0, y: 0, width: self.bounds.size.width - 5, height: self.bounds.height)
        let titleField = UITextField(frame: cgRect)
        titleField.backgroundColor = .black
        return titleField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupUI(frame: CGRect) {
        self.addSubview(titleField)
    }
}

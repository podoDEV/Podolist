//
//  PodoWriteView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodoWriteView: UIView {

    var delegate: UITextFieldDelegate? {
        didSet {
            self.titleField.delegate = delegate
            self.titleField.becomeFirstResponder()
        }
    }

    var y: CGFloat = CGFloat() {
        didSet {
            self.frame.origin.y = y
        }
    }

    var height: CGFloat = CGFloat() {
        didSet {
            self.frame.size.height = height
        }
    }

    lazy var titleField: UITextField = {
        let cgRect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let titleField = UITextField(frame: cgRect)
        titleField.backgroundColor = .white
        return titleField
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(titleField)
    }

    func updateUI() {

    }
}

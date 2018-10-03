//
//  PodoWriteView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodoWriteView: BaseView {

    @IBOutlet weak var roundView: UIView! {
        didSet {
            roundView.layer.cornerRadius = 17.25
            roundView.clipsToBounds = true
        }
    }
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var writeButton: NSLayoutConstraint!

    var delegate: UITextViewDelegate? {
        didSet {
//            self.titleView.delegate = delegate
//            self.titleView.becomeFirstResponder()
        }
    }
//
//    var y: CGFloat = CGFloat() {
//        didSet {
//            self.frame.origin.y = y
//        }
//    }
//
//    var height: CGFloat = CGFloat() {
//        didSet {
//            self.frame.size.height = height
//        }
//    }
//
//    lazy var titleField: UITextField = {
//        let cgRect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
//        let titleField = UITextField(frame: cgRect)
//        titleField.backgroundColor = .white
//        return titleField
//    }()

    override func setupUI() {
        self.backgroundColor = .grayE
//        self.addSubview(titleField)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        roundView.rounding()

    }

    func updateUI() {

    }
}

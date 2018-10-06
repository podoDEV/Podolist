//
//  PodoWriteTitleView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

class PodoWriteTitleView: BaseView {

    weak var delegate: WriteViewDelegate?

    @IBOutlet weak var detailButton: UIButton! {
        didSet {
            detailButton.setBackgroundImage(InterfaceImage.add.image(.normal), for: .normal)
            detailButton.setBackgroundImage(InterfaceImage.add.image(.normal), for: .selected)
        }
    }
    @IBOutlet weak var titleView: UITextView! {
        didSet {
            titleView.textColor = .appColor1
            titleView.font = .appFontM(size: 13)
        }
    }
    @IBOutlet weak var sendButton: UIButton! {
        didSet {
            sendButton.setBackgroundImage(InterfaceImage.send.image(.normal), for: .normal)
            sendButton.setBackgroundImage(InterfaceImage.send.image(.normal), for: .selected)
        }
    }
}

extension PodoWriteTitleView {

    @IBAction func detailAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.didTappedDetail()
        }
    }

    @IBAction func sendAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.didTappedSend()
        }
    }
}

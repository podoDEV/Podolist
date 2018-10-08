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
            detailButton.setImage(InterfaceImage.add.image(.normal), for: .normal)
        }
    }
    @IBOutlet weak var titleField: UITextField! {
        didSet {
            titleField.textColor = .appColor1
            titleField.font = .appFontM(size: 13)
        }
    }
    @IBOutlet weak var createButton: UIButton! {
        didSet {
            createButton.layer.cornerRadius = createButton.bounds.width/2
            createButton.clipsToBounds = true
            createButton.setImage(InterfaceImage.create.image(.normal), for: .normal)
            createButton.backgroundColor = .appColor1
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

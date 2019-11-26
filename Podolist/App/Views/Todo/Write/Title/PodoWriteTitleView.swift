//
//  PodoWriteTitleView.swift
//  Podolist
//
//  Created by hb1love on 2019/10/27.
//  Copyright © 2019 podo. All rights reserved.
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
            createButton.isEnabled = false
            createButton.backgroundColor = .grayE
            createButton.setImage(InterfaceImage.create.image(.normal), for: .normal)
        }
    }
    var canCreate: Bool! {
        didSet {
            if canCreate {
                UIView.animate(withDuration: 0.1) {
                    self.createButton.isEnabled = true
                    self.createButton.backgroundColor = .appColor1
                    self.createButton.setImage(InterfaceImage.create.image(.normal), for: .normal)
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.createButton.isEnabled = false
                    self.createButton.backgroundColor = .grayE
                    self.createButton.setImage(InterfaceImage.create.image(.normal), for: .normal)
                }
            }
        }
    }
    var mode: WritingMode?
    var expanded: Bool = false {
        didSet {
            if expanded {
                detailButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
            } else {
                detailButton.transform = .identity
            }
        }
    }

    func update(_ title: String?, mode: WritingMode) {
        createButton.isEnabled = true
        let text = title ?? ""
        titleField.text = text
        canCreate = !text.isEmpty
        self.mode = mode
        switch mode {
        case .create:
            self.createButton.setImage(InterfaceImage.create.image(.normal), for: .normal)
        case .edit:
            self.createButton.setImage(UIImage(named: "ic_edit"), for: .normal)
        }
    }
}

extension PodoWriteTitleView {

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        let title = sender.text ?? ""
        canCreate = !title.isEmpty

        delegate?.textFieldDidChange(text: title)
    }

    @IBAction func detailAction(_ sender: Any) {
        delegate?.didTappedDetail()
    }

    @IBAction func createAction(_ sender: UIButton) {
        sender.isEnabled = false
        if self.mode == .edit {
            delegate?.didTappedEdit()
        } else {
            delegate?.didTappedCreate()
        }
    }
}

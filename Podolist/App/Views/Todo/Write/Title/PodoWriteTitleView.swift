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

    func update(_ title: String?) {
        // detailButton init
        let text = title ?? ""
        titleField.text = text
        canCreate = !text.isEmpty
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

    @IBAction func createAction(_ sender: Any) {
        delegate?.didTappedCreate()
    }
}

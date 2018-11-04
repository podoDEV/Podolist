//
//  PodolistRowCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodolistRowCell: UITableViewCell {
    static let Identifier = "PodolistRowCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var completeImage: UIImageView!
    @IBOutlet weak var completeView: UIView!

    weak var presenter: PodolistPresenterProtocol?
    var item: Podo? {
        didSet {
            titleLabel.text = item?.title
            titleLabel.textColor = .white
            titleLabel.font = .appFontR(size: 12)
            roundView.layer.cornerRadius = 17.25
            roundView.clipsToBounds = true
            priorityView.layer.cornerRadius = priorityView.bounds.width/2
            priorityView.clipsToBounds = true
            priorityView.isUserInteractionEnabled = false
            completeImage.image = InterfaceImage.complete.normalImage
            completeImage.isUserInteractionEnabled = false
            let tap = UITapGestureRecognizer(target: self, action: #selector(tappedComplete))
            completeView.addGestureRecognizer(tap)
//            addGestureRecognizer(tap)
            update()
        }
    }

    func update() {
        guard let item = item else { return }
        if item.isCompleted {
            completeImage.isHidden = false
            priorityView.backgroundColor = .backgroundColor2
            roundView.backgroundColor = .todoBackground2
        } else {
            completeImage.isHidden = true
            roundView.backgroundColor = .todoBackground1
            priorityView.backgroundColor = item.priority.backgroundColor()
        }
    }

    @objc func tappedComplete() {
        presenter?.didTappedComplete(id: (item?.id)!, completed: (item?.isCompleted)!)
    }
}

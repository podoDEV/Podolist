//
//  PodolistRowCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodolistRowCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var completeImage: UIImageView!
    @IBOutlet weak var completeView: UIView!

    weak var presenter: PodolistPresenterProtocol?

    var podo: Podo?
    var indexPath: IndexPath?

    func configureWith(_ podo: Podo, indexPath: IndexPath) {
        self.podo = podo
        self.indexPath = indexPath
        titleLabel.text = podo.title
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
        update()
    }

    func update() {
        guard let podo = self.podo else { return }
        if podo.isCompleted {
            completeImage.isHidden = false
            roundView.backgroundColor = .todoBackground2
            priorityView.backgroundColor = .backgroundColor2
            priorityView.layer.borderColor = UIColor.backgroundColor2.cgColor
        } else {
            completeImage.isHidden = true
            roundView.backgroundColor = .todoBackground1
            priorityView.backgroundColor = .white
            priorityView.layer.borderColor = podo.priority.backgroundColor().cgColor
            priorityView.layer.borderWidth = 1.5
        }
    }

    @objc func tappedComplete() {
        guard let podo = self.podo, let indexPath = self.indexPath else { return }
        podo.isCompleted.toggle()
        update()
        presenter?.didChangedComplete(indexPath: indexPath, completed: podo.isCompleted)
    }
}

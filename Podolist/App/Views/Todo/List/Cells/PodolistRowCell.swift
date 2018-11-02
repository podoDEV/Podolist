//
//  PodolistTableViewCell.swift
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

    var item: ViewModelPodo? {
        didSet {
            titleLabel.text = item?.title
            titleLabel.textColor = .white
            titleLabel.font = .appFontR(size: 12)
            roundView.layer.cornerRadius = 17.25
            roundView.clipsToBounds = true
            priorityView.layer.cornerRadius = priorityView.bounds.width/2
            priorityView.clipsToBounds = true
            priorityView.backgroundColor = item?.priority?.backgroundColor()
        }
    }
}

//
//  PodoTableViewCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodoTableViewCell: UITableViewCell {
    static let Identifier = "PodoTableCell"

    @IBOutlet weak var titleLabel: UILabel!

    func set(forPodo podo: ViewModelPodo) {
        self.selectionStyle = .none
        titleLabel.text = podo.title
    }
}

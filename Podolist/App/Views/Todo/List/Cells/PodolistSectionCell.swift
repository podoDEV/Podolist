//
//  PodolistSectionCell.swift
//  Podolist
//
//  Created by NHNEnt on 02/11/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

class PodolistSectionCell: UITableViewCell {
    static let Identifier = "PodolistSectionCell"

    @IBOutlet weak var titleLabel: UILabel!

    var item: ViewModelPodoGroup? {
        didSet {
            self.backgroundColor = .white
            titleLabel.text = item?.title
            titleLabel.textColor = .red
            titleLabel.font = .appFontB(size: 13)
        }
    }
}

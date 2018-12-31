//
//  PodolistSectionCell.swift
//  Podolist
//
//  Created by NHNEnt on 02/11/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

class PodolistSectionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func configureWith(_ title: String, color: UIColor) {
        self.backgroundColor = .white
        titleLabel.text = title
        titleLabel.textColor = color
        titleLabel.font = .appFontB(size: 13)
    }
}

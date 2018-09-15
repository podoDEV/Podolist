//
//  SettingTableViewCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let Identifier = "SettingTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!

    var item: ViewModelSettingRow? {
        didSet {
            titleLabel.text = item?.title
        }
    }
}

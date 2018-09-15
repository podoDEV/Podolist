//
//  SettingTableViewLogoutCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class SettingTableViewLogoutCell: UITableViewCell {
    static let Identifier = "SettingTableViewLogoutCell"

    @IBOutlet weak var titleLabel: UILabel!

    var item: ViewModelSettingRow? {
        didSet {
            titleLabel.text = item?.title
            titleLabel.textColor = .red
        }
    }
}

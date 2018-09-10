//
//  SettingTableViewCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let Identifier = "SettingTableCell"

    @IBOutlet weak var titleLabel: UILabel!

    func set(forSetting setting: Setting) {
        self.selectionStyle = .none
        titleLabel.text = setting.title
    }
}

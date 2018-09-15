//
//  ViewModelSettingAccountItem.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class ViewModelSettingAccountItem: ViewModelSettingSection {
    var type: SettingSectionType {
        return .account
    }

    var sectionTitle: String {
        return " "
    }

    var row: ViewModelSettingRow

    init(row: ViewModelSettingRow) {
        self.row = row
    }
}

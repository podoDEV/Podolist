//
//  ViewModelSettingLogoutItem.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class ViewModelSettingLogoutItem: ViewModelSettingSection {
    var type: SettingSectionType {
        return .logout
    }

    var sectionTitle: String {
        return " "
    }

    var row: ViewModelSettingRow

    init(row: ViewModelSettingRow) {
        self.row = row
    }
}

//
//  ViewModelSettingOthersItem.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class ViewModelSettingOthersItem: ViewModelSettingSection {
    var type: SettingSectionType {
        return .others
    }

    var sectionTitle: String {
        return " "
    }

    var rowCount: Int {
        return 3
    }

    var rows: [ViewModelSettingRow]

    init(rows: [ViewModelSettingRow]) {
        self.rows = rows
    }
}

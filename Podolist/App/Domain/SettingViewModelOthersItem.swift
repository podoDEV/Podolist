//
//  SettingViewModelOthersItem.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class SettingViewModelOthersItem: SettingViewModelItem {
    var type: SettingViewModelItemType {
        return .others
    }

    var sectionTitle: String {
        return " "
    }

    var rowCount: Int {
        return 3
    }

    var attributes: [Attribute]

    init(attributes: [Attribute]) {
        self.attributes = attributes
    }
}

//
//  SettingViewModelInfoItem.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class SettingViewModelAccountItem: SettingViewModelItem {
    var type: SettingViewModelItemType {
        return .account
    }

    var sectionTitle: String {
        return " "
    }

    var attribute: Attribute

    init(attribute: Attribute) {
        self.attribute = attribute
    }
}

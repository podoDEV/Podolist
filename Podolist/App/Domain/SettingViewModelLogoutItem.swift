//
//  SettingViewModelLogoutItem.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class SettingViewModelLogoutItem: SettingViewModelItem {
    var type: SettingViewModelItemType {
        return .logout
    }

    var sectionTitle: String {
        return " "
    }

    var attribute: Attribute

    init(attribute: Attribute) {
        self.attribute = attribute
    }
}

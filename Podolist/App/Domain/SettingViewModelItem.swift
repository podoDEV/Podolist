//
//  SettingViewModelItem.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

protocol SettingViewModelItem {
    var type: SettingViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension SettingViewModelItem {
    var rowCount: Int {
        return 1
    }
}

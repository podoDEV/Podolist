//
//  ViewModelSettingSection.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

protocol ViewModelSettingSection {
    var type: SettingSectionType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension ViewModelSettingSection {
    var rowCount: Int {
        return 1
    }
}

//
//  Setting.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class Setting {
    var items: [SettingViewModelItem]?

    init(items: [SettingViewModelItem]) {
        self.items = items
    }

    struct SettingViewModelItem {
        var title: String?
        var imageUrl: String?
    }
}

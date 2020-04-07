//
//  TodoSection.swift
//  Podolist
//
//  Created by hb1love on 2019/10/27.
//  Copyright © 2019 podo. All rights reserved.
//

import Core

class TodoSection {
    var title: String
    var color: UIColor
    var rows: [Todo]
    var editable: Bool
    var visible: Bool

    init(
        title: String,
        color: UIColor,
        rows: [Todo],
        editable: Bool = false,
        visible: Bool = true
        ) {
        self.title = title
        self.color = color
        self.rows = rows
        self.editable = editable
        self.visible = visible
    }
}

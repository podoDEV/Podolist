//
//  PodoSection.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

class PodoSection {
    var title: String
    var color: UIColor
    var rows: [Podo]
    var editable: Bool
    var visible: Bool

    init(
        title: String,
        color: UIColor,
        rows: [Podo],
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

extension PodoSection: Equatable, Hashable {
    var hashValue: Int {
        return title.hashValue
    }

    static func == (lhs: PodoSection, rhs: PodoSection) -> Bool {
        return lhs.title == rhs.title
    }
}

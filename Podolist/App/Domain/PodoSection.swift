//
//  PodoSection.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

struct PodoSection {
    var title: String
    var color: UIColor
    var rows: [Podo]
}

extension PodoSection: Equatable, Hashable {
    var hashValue: Int {
        return title.hashValue
    }

    static func == (lhs: PodoSection, rhs: PodoSection) -> Bool {
        return lhs.title == rhs.title
    }
}

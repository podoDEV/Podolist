//
//  GroupHeader.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

struct GroupHeader {
    var title: String?

    init(title: String?) {
        self.title = title
    }
}

extension GroupHeader: Equatable, Hashable {
    var hashValue: Int {
        return title.hashValue
    }

    static func == (lhs: GroupHeader, rhs: GroupHeader) -> Bool {
        return lhs.title == rhs.title
    }
}

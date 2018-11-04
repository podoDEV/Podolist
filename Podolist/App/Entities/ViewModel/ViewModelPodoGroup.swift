//
//  ViewModelPodoGroup.swift
//  Podolist
//
//  Created by NHNEnt on 02/11/2018.
//  Copyright © 2018 podo. All rights reserved.
//

class ViewModelPodoGroup {

//    var priority: Int?
    var title: String?

    init(title: String?) {
//        self.priority = priority
        self.title = title
    }
}

extension ViewModelPodoGroup: Equatable, Hashable {
    var hashValue: Int {
        return title.hashValue
    }

    static func == (lhs: ViewModelPodoGroup, rhs: ViewModelPodoGroup) -> Bool {
        return lhs.title == rhs.title
    }
}

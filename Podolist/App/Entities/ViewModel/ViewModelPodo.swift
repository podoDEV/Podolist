//
//  ViewModelPodo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class ViewModelPodo {
    var id: Int?
    var title: String?
    var isCompleted: Bool?
    var startedAt: Date?
    var endedAt: Date?
    var priority: Priority?

    init(id: Int?, title: String?, isCompleted: Bool?, startedAt: Date?, endedAt: Date?, priority: Priority?) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.priority = priority
    }

    convenience init(podo: Podo) {
        self.init(id: podo.id,
                  title: podo.title,
                  isCompleted: podo.isCompleted,
                  startedAt: podo.startedAt,
                  endedAt: podo.endedAt,
                  priority: podo.priority)
    }
}

//
//  Podo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

struct Podo {
    var id: Int?
    var title: String?
    var isCompleted = false
    var startedAt = Date()
    var endedAt = Date()
    var updatedAt: Int?
    var priority: Priority = .none

    init() {}

    init(id: Int, title: String, isCompleted: Bool, startedAt: Int, endedAt: Int, updatedAt: Int, priority: Priority?) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.startedAt = Date(seconds: TimeInterval(startedAt))
        self.endedAt = Date(seconds: TimeInterval(endedAt))
        self.updatedAt = updatedAt
        self.priority = priority ?? .none
    }

    init(responsePodo: ResponsePodo) {
        self.init(id: responsePodo.id!,
                  title: responsePodo.title!,
                  isCompleted: responsePodo.isCompleted!,
                  startedAt: responsePodo.startedAt!,
                  endedAt: responsePodo.endedAt!,
                  updatedAt: responsePodo.updatedAt!,
                  priority: responsePodo.priority)
    }
}

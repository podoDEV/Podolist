//
//  Podo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class Podo {
    var id: Int?
    var title: String?
    var isCompleted = false
    var startedAt = Date()
    var endedAt = Date()
    var dueAt = Date()
    var updatedAt: Date?
    var priority: Priority = .none

    init() {}

    init(
        id: Int,
        title: String,
        isCompleted: Bool,
        startedAt: Date,
        endedAt: Date,
        dueAt: Date,
        updatedAt: Date,
        priority: Priority?
        ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.dueAt = dueAt
        self.updatedAt = updatedAt
        self.priority = priority ?? .none
    }

    convenience init(responsePodo: ResponsePodo) {
        self.init(
            id: responsePodo.id!,
            title: responsePodo.title!,
            isCompleted: responsePodo.isCompleted!,
            startedAt: responsePodo.startedAt!,
            endedAt: responsePodo.endedAt!,
            dueAt: responsePodo.dueAt!,
            updatedAt: responsePodo.updatedAt!,
            priority: responsePodo.priority
        )
    }
}

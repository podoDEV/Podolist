//
//  RequestPodo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

struct RequestPodo {
    let title: String
    let isCompleted: Bool
    let startedAt: Date
    let endedAt: Date
    let dueAt: Date
    let updatedAt: Date?
    let priority: Priority

    init(
        title: String,
        isCompleted: Bool,
        startedAt: Date,
        endedAt: Date,
        dueAt: Date,
        updatedAt: Date?,
        priority: Priority
        ) {
        self.title = title
        self.isCompleted = isCompleted
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.dueAt = dueAt
        self.updatedAt = updatedAt
        self.priority = priority
    }

    init(podo: Podo) {
        self.init(
            title: podo.title!,
            isCompleted: podo.isCompleted,
            startedAt: podo.startedAt,
            endedAt: podo.endedAt,
            dueAt: podo.dueAt,
            updatedAt: podo.updatedAt,
            priority: podo.priority
        )
    }

    var asDicsionary: [String: Any] {
        return ["title": title,
                "isCompleted": isCompleted,
                "startedAt": startedAt.timeIntervalSince1970,
                "endedAt": endedAt.timeIntervalSince1970,
                "dueAt": dueAt.timeIntervalSince1970,
                "priority": priority.rawValue]
    }
}

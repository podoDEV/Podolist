//
//  RequestPodo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

struct RequestPodo {
    let title: String
    let isCompleted: Bool
    let startedAt: Int
    let endedAt: Int
    let updatedAt: Int?
    let priority: Priority

    init(title: String, isCompleted: Bool, startedAt: Int, endedAt: Int, updatedAt: Int?, priority: Priority) {
        self.title = title
        self.isCompleted = isCompleted
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.updatedAt = updatedAt
        self.priority = priority
    }

    init(podo: Podo) {
        self.init(title: podo.title!,
                  isCompleted: podo.isCompleted,
                  startedAt: podo.startedAt,
                  endedAt: podo.endedAt,
                  updatedAt: podo.updatedAt,
                  priority: podo.priority)
    }

    var asDicsionary: [String: Any] {
        return ["title": title,
                "isCompleted": isCompleted,
                "startedAt": startedAt,
                "endedAt": endedAt,
                "priority": priority.rawValue]
    }
}

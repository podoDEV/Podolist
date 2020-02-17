//
//  Todo.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

class Todo: Codable {
    var id: Int?
    var title: String?
    var isCompleted: Bool?
    var startedAt: Date?
    var endedAt: Date?
    var dueAt: Date?
    var updatedAt: Date?
    var priority: Priority?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isCompleted
        case startedAt
        case endedAt
        case dueAt
        case updatedAt
        case priority
    }

    init() {
        let date = Date()
        isCompleted = false
        startedAt = date
        endedAt = date
        dueAt = date
        priority = .medium
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        title = try? values.decodeIfPresent(String.self, forKey: .title)
        isCompleted = try? values.decodeIfPresent(Bool.self, forKey: .isCompleted)
        if let startedAt = try? values.decodeIfPresent(Int.self, forKey: .startedAt) {
            self.startedAt = Date(seconds: TimeInterval(startedAt))
        }
        if let endedAt = try? values.decodeIfPresent(Int.self, forKey: .endedAt) {
            self.endedAt = Date(seconds: TimeInterval(endedAt))
        }
        if let dueAt = try? values.decodeIfPresent(Int.self, forKey: .dueAt) {
            self.dueAt = Date(seconds: TimeInterval(dueAt))
        }
        if let updatedAt = try? values.decodeIfPresent(Int.self, forKey: .updatedAt) {
            self.updatedAt = Date(seconds: TimeInterval(updatedAt))
        }
        priority = try? values.decodeIfPresent(Priority.self, forKey: .priority)
    }

    var asParameters: [String: Any] {
        var parameters: [String: Any] = [:]
        if let title = title {
            parameters["title"] = title
        }
        if let isCompleted = isCompleted {
            parameters["isCompleted"] = isCompleted
        }
        if let startedAt = startedAt {
            parameters["startedAt"] = startedAt.timeIntervalSince1970
        }
        if let endedAt = endedAt {
            parameters["endedAt"] = endedAt.timeIntervalSince1970
        }
        if let dueAt = dueAt {
            parameters["dueAt"] = dueAt.timeIntervalSince1970
        }
        if let priority = priority {
            parameters["priority"] = priority.rawValue
        }
        return parameters
    }
}

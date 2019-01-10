//
//  ResponsePodo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class ResponsePodo: JSONable {
    var id: Int?
    var title: String?
    var isCompleted: Bool?
    var startedAt: Date?
    var endedAt: Date?
    var dueAt: Date?
    var updatedAt: Date?
    var priority: Priority?

    required init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        isCompleted = json["isCompleted"].boolValue
        startedAt = Date(seconds: TimeInterval(json["startedAt"].intValue))
        endedAt = Date(seconds: TimeInterval(json["endedAt"].intValue))
        dueAt = Date(seconds: TimeInterval(json["dueAt"].intValue))
        updatedAt = Date(seconds: TimeInterval(json["updatedAt"].intValue))
        priority = Priority(rawValue: json["priority"].stringValue)
    }
}

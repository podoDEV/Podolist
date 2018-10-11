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
    var startedAt: Int?
    var endedAt: Int?
    var updatedAt: Int?
    var priority: Priority?

    required init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        isCompleted = json["isCompleted"].boolValue
        startedAt = json["startedAt"].intValue
        endedAt = json["endedAt"].intValue
        updatedAt = json["updatedAt"].intValue
        priority = Priority(rawValue: json["priority"].stringValue)
    }
}

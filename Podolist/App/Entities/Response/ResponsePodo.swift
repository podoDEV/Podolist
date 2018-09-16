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

    init(id: Int, title: String, isCompleted: Bool, startedAt: Int, endedAt: Int, updatedAt: Int) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.updatedAt = updatedAt
    }

    required init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        isCompleted = json["isCompleted"].boolValue
        startedAt = json["startedAt"].intValue
        endedAt = json["endedAt"].intValue
        updatedAt = json["updatedAt"].intValue
    }
}

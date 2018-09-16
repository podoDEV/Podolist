//
//  Podo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class Podo: JSONable {
    var id: Int?
    var title: String?
    var isCompleted: Bool?
    var startedAt: Int?
    var endedAt: Int?
    var updatedAt: Int?

    init(id: Int?, title: String?, isCompleted: Bool?, startedAt: Int?, endedAt: Int?, updatedAt: Int?) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.updatedAt = updatedAt
    }

    required init(json: JSON) {
        id = json["itemId"].intValue
        title = json["description"].stringValue
        isCompleted = json["isCompleted"].boolValue
        startedAt = json["startedAt"].intValue
        endedAt = json["endedAt"].intValue
        updatedAt = json["updatedAt"].intValue
    }

    convenience init(responsePodo: ResponsePodo) {
        self.init(id: responsePodo.id,
                  title: responsePodo.title,
                  isCompleted: responsePodo.isCompleted,
                  startedAt: responsePodo.startedAt,
                  endedAt: responsePodo.endedAt,
                  updatedAt: responsePodo.updatedAt)
    }
}

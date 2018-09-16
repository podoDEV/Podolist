//
//  RequestPodo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class RequestPodo: JSONable {
    var id: Int?
    var title: String?

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }

    required init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
    }
}

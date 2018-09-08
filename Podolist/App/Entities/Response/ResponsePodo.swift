//
//  ResponsePodo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class ResponsePodo: JSONable {
    var id: String?
    var title: String?

    init(id: String, title: String) {
        self.id = id
        self.title = title
    }

    required init(json: JSON) {
        id = json["id"].stringValue
        title = json["title"].stringValue
    }
}

//
//  JsonPayload.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class JsonPayload<Result>: JSONable {
    var header: JsonHeader?
    var result: Result?

    required init(json: JSON) {
        header = json["header"].to(type: JsonHeader.self) as? JsonHeader
        result = json["result"].to(type: Result.self) as? Result
    }
}

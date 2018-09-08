//
//  JsonResults.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class JsonResults<Element>: JSONable {
    var count: Int?
    var contents: [Element]?

    required init(json: JSON) {
        count = json["count"].intValue
        contents = []
        for obj in json["contents"].arrayValue {
            let content = obj.to(type: Element.self) as? Element
            contents?.append(content!)
        }
    }
}

//
//  JsonResult.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class JsonResult<Element>: JSONable {
    var content: Element?

    required init?(json: JSON) {
        content = json.to(type: Element.self) as? Element
    }
}

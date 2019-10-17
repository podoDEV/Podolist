//
//  ResponsePodolist.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftyJSON

class ResponsePodolist: JSONable {
    var delayedItems: [ResponsePodo]
    var items: [ResponsePodo]

    required init(json: JSON) {
        var delayed = [ResponsePodo]()
        for jsonPodo in JSON(json["delayedItems"]).arrayValue {
            let item = jsonPodo.to(type: ResponsePodo.self) as! ResponsePodo
            delayed.append(item)
        }
        delayedItems = delayed

        var temp = [ResponsePodo]()
        for jsonPodo in JSON(json["items"]).arrayValue {
            let item = jsonPodo.to(type: ResponsePodo.self) as! ResponsePodo
            temp.append(item)
        }
        items = temp
    }
}

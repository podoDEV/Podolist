//
//  JSONable.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

protocol JSONable {
    init?(json: JSON)
}

extension JSON {
    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? JSONable.Type {
            if self.type == .array {
                var arrObject: [Any] = []
                for obj in self.arrayValue {
                    let object = baseObj.init(json: obj)
                    arrObject.append(object!)
                }
                return arrObject
            } else {
                let object = baseObj.init(json: self)
                return object!
            }
        }
        return nil
    }
}

//
//  ResponseAccount.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftyJSON

class ResponseAccount: JSONable {
    var id: Int?
    var name: String?
    var provider: Int?
    var providerId: Int?

    required init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        provider = json["provider"].intValue
        providerId = json["providerId"].intValue
    }
}

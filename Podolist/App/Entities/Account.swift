//
//  Account.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class Account: JSONable {
    var id: Int?
    var name: String?
    var provider: Int?
    var providerId: Int?

    init(id: Int?, name: String?, provider: Int?, providerId: Int?) {
        self.id = id
        self.name = name
        self.provider = provider
        self.providerId = providerId
    }

    required init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        provider = json["provider"].intValue
        providerId = json["providerId"].intValue
    }
}

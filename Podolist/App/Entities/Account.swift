//
//  Account.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

struct Account: JSONable {
    var id: Int?
    var name: String?
    var provider: Int?
    var providerId: Int?

//    init(name: String?) {
//        self.name = name
//    }
//
//    init(responseAccount: ResponseAccount) {
//        self.init(name: responseAccount.name)
//    }

    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        provider = json["provider"].intValue
        providerId = json["providerId"].intValue
    }
}

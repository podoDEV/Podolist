//
//  Account.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class Account: JSONable {
    var pictureUrl: String?
    var name: String?
    var email: String?

    init(pictureUrl: String?, name: String, email: String) {
        self.pictureUrl = pictureUrl
        self.name = name
        self.email = email
    }

    required init(json: JSON) {
        pictureUrl = json["pictureUrl"].stringValue
        name = json["name"].stringValue
        email = json["email"].stringValue
    }
}

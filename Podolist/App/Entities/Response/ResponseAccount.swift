//
//  ResponseAccount.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftyJSON

class ResponseAccount: JSONable {
    var id: Int
    var name: String
    var email: String?
    var imageUrl: String?
    var provider: String?
    var providerId: String?

    required init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        email = json["email"].stringValue
        imageUrl = json["profileImageUrl"].stringValue
        provider = json["provider"].stringValue
        providerId = json["providerId"].stringValue
    }
}

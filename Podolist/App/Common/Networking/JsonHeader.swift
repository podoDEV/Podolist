//
//  Header.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

class JsonHeader: JSONable {
    var isSuccessful: Bool?
    var errorCode: Int?
    var errorMessage: String?

    required init(json: JSON) {
        isSuccessful = json["isSuccessful"].boolValue
        errorCode = json["errorCode"].intValue
        errorMessage = json["errorMessage"].stringValue
    }
}

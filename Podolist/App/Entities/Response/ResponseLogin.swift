//
//  ResponseAccount.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftyJSON

class ResponseLogin: JSONable {
    var session: Session?
    var responseAccount: ResponseAccount?

    required init(json: JSON) {
        session = json["sessionId"].stringValue
        responseAccount = json["user"].to(type: ResponseAccount.self) as? ResponseAccount
    }
}

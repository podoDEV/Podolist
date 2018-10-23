//
//  Account.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftyJSON

struct Account {
    var id: Int?
    var name: String?
    var provider: Int?
    var providerId: Int?

    init(name: String?) {
        self.name = name
    }

    init(responseAccount: ResponseAccount) {
        self.init(name: responseAccount.name)
    }
}

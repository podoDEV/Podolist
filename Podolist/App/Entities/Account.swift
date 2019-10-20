//
//  Account.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

class Account: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    var provider: String?
    var providerId: String?
}

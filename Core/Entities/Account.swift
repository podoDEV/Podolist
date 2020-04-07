//
//  Account.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

public class Account: Codable {
    public var id: Int?
    public var name: String?
    public var email: String?
    public var profileImageUrl: String?
    public var provider: String?
    public var providerId: String?
}

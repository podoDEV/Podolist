//
//  AccessToken.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

struct AccessToken {
    let id: String

    var asDicsionary: [String: Any] {
        return ["accessToken": id] as [String: Any]
    }
}

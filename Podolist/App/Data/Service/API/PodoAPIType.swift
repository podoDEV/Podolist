//
//  PodoAPI.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Alamofire
import SwiftDate

final class PodoAPIType {

    static func makePodoParams(page: Int, date: Date) -> Parameters {
        var parameters = Parameters()
//        parameters["page"] = page
//        parameters["size"] = 100

        parameters["date"] = date.stringYYYYMMDD()
        return parameters
    }

    static func makeLoginParams(provider: AuthProvider) -> Parameters {
        var parameters = Parameters()

        switch provider {
        case .kakao(let accessToken):
            parameters["accessToken"] = accessToken
        case .anonymous(let uuid):
            parameters["uuid"] = uuid
        }
        return parameters
    }
}

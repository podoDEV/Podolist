//
//  AuthAPI.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation
import Moya

enum AuthAPI {
    case login(provider: AuthProvider)
    case logout
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://myshort.info/api")!
    }

    var path: String {
        switch self {
        case .login(let provider): return "login/\(provider.rawValue)"
        case .logout: return "logout"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .login(let provider):
            switch provider {
            case .kakao(let accessToken):
                return .requestParameters(
                    parameters: ["accessToken": accessToken],
                    encoding: JSONEncoding.default
                )
            case .anonymous(let uuid):
                return .requestParameters(
                    parameters: ["uuid": uuid],
                    encoding: JSONEncoding.default
                )
            }
        case .logout:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}

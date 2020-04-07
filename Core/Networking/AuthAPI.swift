//
//  AuthAPI.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation
import Moya

public enum AuthAPI {
    case login(provider: AuthProvider)
    case logout

    case me
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return URL(string: AppUtils.baseURL)!
    }

    public var path: String {
        switch self {
        case .login(let provider): return "login/\(provider.rawValue())"
        case .logout: return "logout"
        case .me: return "users/me"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .me: return .get
        default:
            return .post
        }
    }

    public var task: Task {
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
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    public var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}

//
//  AuthPlugin.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Moya

final struct AuthPlugin: PluginType {
    private let authService: AuthServiceType

    init(authService: AuthServiceType) {
        self.authService = authService
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let session = self.authService.current {
            request.addValue("SESSIONID=" + session + ";", forHTTPHeaderField: "Cookie")
        }
        return request
    }
}

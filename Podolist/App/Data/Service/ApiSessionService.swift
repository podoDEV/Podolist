//
//  SessionService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire

final class ApiSessionService: ApiServiceProtocol {
    static let shared = ApiSessionService()
    var service: SessionManager?
    private init() {}

    func api() -> SessionManager {
        PodoKeychain.shared.saveToken(token: "temp")
        service = SessionManager()
        guard PodoKeychain.shared.hasToken() else {
            return service!
        }

        PodoKeychain.shared.findToken(
            onSuccess: { accessToken in
                if let accessToken = accessToken {
                    self.service!.adapter = AccessTokenAdapter(accessToken: accessToken)
                }
            }, onError: { error in

            })
        return service!
    }
}

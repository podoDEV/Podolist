//
//  SessionService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire

final class ApiSessionService: ApiServiceProtocol {
    static let shared = ApiSessionService()
    var podoService: SessionManager?
    private init() {}

    func api() -> SessionManager {
        if let podoService = podoService {
            return podoService
        }
        podoService = SessionManager()
        guard PodoKeychain.shared.hasToken() else {
            return podoService!
        }

        PodoKeychain.shared.findToken(
            onSuccess: { accessToken in
                if let accessToken = accessToken {
                    self.podoService?.adapter = AccessTokenAdapter(accessToken: accessToken)
                }
            }, onError: { error in

            })
        return podoService!
    }
}

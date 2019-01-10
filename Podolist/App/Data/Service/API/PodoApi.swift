//
//  PodoApi.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire

final class PodoApiManager: ApiServiceProtocol {
    var api: SessionManager

    init() {
        api = SessionManager.default
        var podoSession: Session?

        KeychainService.shared.findSession(
            onSuccess: { session in
                podoSession = session
        })

        api.adapter = PodoRequestAdapter(session: podoSession)
    }
}

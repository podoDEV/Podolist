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

        service = SessionManager()
        guard KeychainService.shared.hasValue(key: "session") else {
            return service!
        }

        KeychainService.shared.findValue(
            onSuccess: { session in
                if let session = session {
                    self.service!.adapter = SessionAdapter(session: session)
                }
            }, onError: { error in

            })
        return service!
    }
}

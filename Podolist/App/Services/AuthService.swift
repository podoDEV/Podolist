//
//  AuthService.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import KeychainAccess
import Moya

protocol AuthServiceType {
    var current: Session? { get }

    func authorize(_ provider: AuthProvider, _ completion: @escaping (Result<(), PodoError>) -> Void)
    func logout()
}

final class AuthService: AuthServiceType {
    private let networking: AuthNetworking

    private let keychain = Keychain(service: "com.podo.podolist")
    private(set) var current: Session?

    init(networking: AuthNetworking) {
        self.networking = networking
        self.current = loadSession()
        log.debug("currentSession exists: \(self.current != nil)")
    }

    func authorize(_ provider: AuthProvider, _ completion: @escaping (Result<(), PodoError>) -> Void) {
        networking.request(.login(provider: provider)) { result in
            switch result {
            case .success(let response):
                if let headers = response.response?.allHeaderFields as? [String: Any],
                    let session = headers["Set-Cookie"] as? Session {
                    self.current = session
                    try? self.saveSession(session)
                    completion(.success)
                    break
                }
                completion(.failure(.parsingError))
            case .failure(let error):
                completion(.failure(.unknown))
            }
        }
    }

    func logout() {}
}

private extension AuthService {
    func saveSession(_ session: Session) throws {
        try keychain.set(session, key: "session")
    }

    func loadSession() -> Session? {
        guard let value = keychain["session"] else { return nil }
        return Session(value)
    }

    func deleteSession() {
        try? keychain.remove("session")
    }
}

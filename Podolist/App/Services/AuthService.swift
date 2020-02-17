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
    typealias Session = String
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
        log.d("currentSession exists: \(self.current != nil)")
    }

    func authorize(_ provider: AuthProvider, _ completion: @escaping (Result<(), PodoError>) -> Void) {
        networking.request(type: .login(provider: provider)) { (result: (Result<ResponseLogin, PodoError>)) -> Void in
            switch result {
            case .success(let responseLogin):
                guard let session = responseLogin.sessionId else {
                    completion(.failure(.unknown))
                    return
                }
                self.current = session
                try? self.saveSession(session)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
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

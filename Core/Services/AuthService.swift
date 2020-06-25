//
//  AuthService.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import KeychainAccess
import Moya

public protocol AuthServiceType {
  typealias Session = String
  var current: AuthServiceType.Session? { get }

  func authorize(_ provider: AuthProvider, _ completion: @escaping (Result<(), PodoError>) -> Void)
  func logout()
}

public final class AuthService: AuthServiceType {
  private let networking: AuthNetworking

  private let keychain: Keychain
  private(set) public var current: AuthServiceType.Session?

  public init(networking: AuthNetworking, serviceName: String, accessGroup: String) {
    self.networking = networking
    self.keychain = Keychain(service: serviceName, accessGroup: accessGroup)
    self.current = loadSession()
    log.debug("currentSession exists: \(self.current != nil)")
  }

  public func authorize(_ provider: AuthProvider, _ completion: @escaping (Result<(), PodoError>) -> Void) {
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

  public func logout() {}
}

private extension AuthService {
  func saveSession(_ session: AuthServiceType.Session) throws {
    try keychain.set(session, key: "session")
  }

  func loadSession() -> AuthServiceType.Session? {
    guard let value = keychain["session"] else { return nil }
    return Session(value)
  }

  func deleteSession() {
    try? keychain.remove("session")
  }
}

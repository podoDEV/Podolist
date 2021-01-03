
import Core
import KeychainAccess
import Moya

public protocol AuthServiceType {
  var session: String? { get }

  func authorize(_ provider: AuthProvider, _ completion: @escaping (Result<(), PodoError>) -> Void)
  func logout()
}

public final class AuthService: AuthServiceType, SessionProvider {
  private let networking: AuthNetworking

  private let keychain: Keychain
  private(set) public var session: String?

  public init(networking: AuthNetworking, serviceName: String, accessGroup: String) {
    self.networking = networking
    self.keychain = Keychain(service: serviceName, accessGroup: accessGroup)
    self.session = loadSession()
    log.debug("currentSession exists: \(self.session != nil)")
  }

  public func authorize(_ provider: AuthProvider, _ completion: @escaping (Result<(), PodoError>) -> Void) {
    networking._request(.login(provider: provider)) { (result: (Result<ResponseLogin, PodoError>)) -> Void in
      switch result {
      case .success(let responseLogin):
        guard let session = responseLogin.sessionId else {
          completion(.failure(.unknown))
          return
        }
        self.session = session
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
  func saveSession(_ session: String) throws {
    try keychain.set(session, key: "session")
  }

  func loadSession() -> String? {
    return keychain["session"]
  }

  func deleteSession() {
    try? keychain.remove("session")
  }
}

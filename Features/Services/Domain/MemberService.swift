
import Core

public protocol MemberServiceType {
  var current: Account? { get }
  
  func me(_ completion: @escaping (Result<Account, PodoError>) -> Void)
}

public final class MemberService: MemberServiceType {
  private let networking: AuthNetworking
  
  private(set) public var current: Account?
  
  public init(networking: AuthNetworking) {
    self.networking = networking
  }
  
  public func me(_ completion: @escaping (Result<Account, PodoError>) -> Void) {
    networking._request(.me) { [weak self] (result: (Result<Account, PodoError>)) -> Void in
      switch result {
      case .success(let account):
        self?.current = account
        completion(.success((account)))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

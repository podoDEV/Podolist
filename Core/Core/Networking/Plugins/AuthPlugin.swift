
import Moya

public protocol SessionProvider {
  var session: String? { get }
}

public struct AuthPlugin: PluginType {
  private let provider: SessionProvider
  
  public init(provider: SessionProvider) {
    self.provider = provider
  }
  
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    if let session = self.provider.session {
      request.addValue("SESSIONID=" + session + ";", forHTTPHeaderField: "Cookie")
    }
    return request
  }
}

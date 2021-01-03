
public enum AuthProvider {
  case kakao(String)
  case anonymous(String)
  
  public func rawValue() -> String {
    switch self {
    case .kakao:
      return "kakao"
    case .anonymous:
      return "anonymous"
    }
  }
}

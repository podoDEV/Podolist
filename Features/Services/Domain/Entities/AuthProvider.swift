
public enum AuthProvider {
  case apple(String)
  case kakao(String)
  case anonymous(String)
  
  public func rawValue() -> String {
    switch self {
    case .apple: return "apple"
    case .kakao: return "kakao"
    case .anonymous: return "anonymous"
    }
  }
}

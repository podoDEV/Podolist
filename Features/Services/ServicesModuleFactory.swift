
import Core

public class ServicesModuleFactory {
  static var config: ServicesConfiguration.Type?
  private static var _config: ServicesConfiguration.Type {
    guard let config = config else {
      preconditionFailure("Please configure ServicesModule before access")
    }
    return config
  }

  static var baseUrl: String = {
    _config.baseUrl
  }()

  static var authPlugin: AuthPlugin = {
    AuthPlugin(provider: sessionProvider)
  }()

  static var sessionProvider: SessionProvider = _authService
  static var _authService: AuthServiceType & SessionProvider = {
    AuthService(
      networking: AuthNetworking(),
      serviceName: _config.serviceName,
      accessGroup: _config.keyChainAccessGroup
    )
  }()

  public static var authService: AuthServiceType = _authService

  public static var memberService: MemberServiceType = {
    MemberService(networking: AuthNetworking(plugins: authPlugin))
  }()

  public static var todoService: TodoServiceType = {
    TodoService(networking: TodoNetworking(plugins: authPlugin))
  }()
}

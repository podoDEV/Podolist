
public class CoreModuleFactory {
  static var config: CoreConfiguration.Type?
  private static var _config: CoreConfiguration.Type {
    guard let config = config else {
      preconditionFailure("Please configure CoreModule before access")
    }
    return config
  }

  public static func authPlugin(sessionProvider provider: SessionProvider) -> AuthPlugin {
    AuthPlugin(provider: provider)
  }
}

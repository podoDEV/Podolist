
import UIKit
import Core
import Resources

public protocol ServicesConfiguration {
  static var baseUrl: String { get }
  static var serviceName: String { get }
  static var keyChainAccessGroup: String { get }
}

public final class Services {
  public static func setup(with config: ServicesConfiguration.Type) {
    ServicesModuleFactory.config = config
  }
}

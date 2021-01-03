
import Umbrella
import SwiftyBeaver

public protocol CoreConfiguration {}

public final class Core {
  public static func setup(with config: CoreConfiguration.Type) {
    log.addDestination(ConsoleDestination())
    analytics.register(provider: FirebaseProvider())
    CoreModuleFactory.config = config
  }
}

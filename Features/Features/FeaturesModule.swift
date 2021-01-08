
import UIKit
import Core
import Resources

public protocol FeaturesConfiguration {
  static var window: UIWindow { get }
}

public final class Features {
  public static func setup(with config: FeaturesConfiguration.Type) {
    UIFont.loadAllFonts()
    FeaturesModuleFactory.config = config
  }
}

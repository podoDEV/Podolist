
import UIKit
import Features
import Services
import Core
import Resources
import Firebase
import KakaoSDKCommon

struct AppDependency {
  let configureModules: () -> Void
  let configureSDKs: () -> Void
  let configureAppearance: () -> Void
  let configureWindow: () -> UIWindow
}

final class CompositionRoot {
  static func resolve() -> AppDependency {
    return AppDependency(
      configureModules: configureModules,
      configureSDKs: configureSDKs,
      configureAppearance: configureAppearance,
      configureWindow: configureWindow
    )
  }

  static func configureModules() {
    Core.setup(with: self)
    Services.setup(with: self)
    Features.setup(with: self)
  }

  static func configureSDKs() {
    let appKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as! String
    KakaoSDKCommon.initSDK(appKey: appKey)
    FirebaseApp.configure()
  }

  static func configureAppearance() {
    UINavigationBar.appearance().shadowImage = UIImage()
  }

  static func configureWindow() -> UIWindow {
    var rootViewController: UIViewController
    if ServicesModuleFactory.authService.session == nil {
      rootViewController = FeaturesModuleFactory.loginVC
    } else {
      let naviController = UINavigationController()
      naviController.viewControllers = [FeaturesModuleFactory.todoVC]
      rootViewController = naviController
    }
    return UIWindow(frame: UIScreen.main.bounds).also {
      $0.rootViewController = rootViewController
      $0.backgroundColor = .white
      $0.makeKeyAndVisible()
    }
  }
}

extension CompositionRoot:
  FeaturesConfiguration,
  ServicesConfiguration,
  CoreConfiguration {

  static var baseUrl: String = {
    #if DEBUG
    return "http://podolist.podo.world:8000/"
    #else
    return "http://podolist.podo.world:8000/"
    #endif
  }()

  static var serviceName: String {
    return "com.podo.podolist.test"
  }

  static var keyChainAccessGroup: String {
    #if DEBUG
    return "7KW522KWZF.com.podo.podolist.test.shared"
    #else
    return "7KW522KWZF.com.podo.podolist.shared"
    #endif
  }
}

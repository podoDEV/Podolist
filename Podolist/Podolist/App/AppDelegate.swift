
import UIKit
import Core
import UserNotifications
import KakaoSDKAuth
import KakaoSDKUser
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  private var dependency: AppDependency!

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.dependency = self.dependency ?? CompositionRoot.resolve()
    self.dependency.configureModules()
    self.dependency.configureSDKs()
    self.dependency.configureAppearance()
    self.window = self.dependency.configureWindow()
    setupPushNotification()

//    self.dependency.wireframe.start()
    return true
  }
}

private extension AppDelegate {
  func setupPushNotification() {
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
      if let error = error as NSError? {
        print("APNS Authorization failure. \(error)")
      } else {
        print("APNS Authorization success.")
      }
    }
    UIApplication.shared.registerForRemoteNotifications()
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    log.info("The notification \"\(notification.request.identifier)\" is presenting. \"\(notification.request.content.body)\"")
    completionHandler([.alert, .badge, .sound])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    log.info("The user responded to the notification \"\(response.notification.request.identifier)\" at \"\(response.notification.date.description(with: .current))\".")
    UIApplication.shared.applicationIconBadgeNumber = 0
    completionHandler()
  }
}

extension AppDelegate {
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    if AuthApi.isKakaoTalkLoginUrl(url) {
      return AuthController.handleOpenUrl(url: url)
    }
    return false
  }
}


import UIKit
import UserNotifications
import AuthenticationServices
import Core
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
    setupNotificationObservers()
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
  
  func setupNotificationObservers() {
    NotificationCenter.default.addObserver(
      forName:  ASAuthorizationAppleIDProvider.credentialRevokedNotification,
      object: nil,
      queue: nil
    ) { _ in
      print("Revoked Notification")
      // 로그인 페이지로 이동
    }
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

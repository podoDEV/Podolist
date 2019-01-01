//
//  AppDelegate.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import UserNotifications
import KakaoOpenSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAnalytics()
        setupKakao()
        setupEntryScreen()
        setupPushNotification()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}

private extension AppDelegate {

    func setupAnalytics() {
        guard let gai = GAI.sharedInstance() else {
            assert(false, "Google Analytics not configured correctly")
            return
        }
        guard let trackingId = Bundle.main.infoDictionary?["GA_TRACKING_ID"] as? String else { return }
        gai.tracker(withTrackingId: trackingId)
        gai.trackUncaughtExceptions = true

        #if DEBUG
            gai.logger.logLevel = .verbose
        #endif
    }

    func setupKakao() {
        #if DEBUG
        #else
            let clientSecret = Bundle.main.infoDictionary?["KAKAO_CLIENT_SECRET"] as! String
            KOSession.shared()?.clientSecret = clientSecret
        #endif
    }

    func setupEntryScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let loginViewController = LoginWireFrame.createLoginModule()
        AppWireframe.shared.setupKeyWindow(window!, viewController: loginViewController)
        UINavigationBar.appearance().barStyle = .blackOpaque
    }

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
        print("The notification \"\(notification.request.identifier)\" is presenting. \"\(notification.request.content.body)\"")
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("The user responded to the notification \"\(response.notification.request.identifier)\" at \"\(response.notification.date.description(with: .current))\".")
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }
}

extension AppDelegate /* For kakao */{

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return true
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return true
    }
}

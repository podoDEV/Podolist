//
//  AppDelegate.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var loginScreen: UIViewController?
//    var mainScreen: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAnalytics()
        setupEntryScreen()
        setupPushNotification()
//        setupObserver()
//        KOSession.shared().clientSecret = SessionConstants.clientSecret;

//        reloadRootViewController()
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

extension AppDelegate {

    func setupAnalytics() {
        guard let gai = GAI.sharedInstance() else {
            assert(false, "Google Analytics not configured correctly")
            return
        }
        let trackingId = Bundle.main.infoDictionary?["GA_TRACKING_ID"] as! String
        gai.tracker(withTrackingId: trackingId)
        gai.trackUncaughtExceptions = true

        #if DEBUG
            gai.logger.logLevel = .verbose
        #endif
    }

    fileprivate func setupEntryScreen() {
        let loginScreen = LoginWireFrame.createLoginModule()
        self.window?.rootViewController = loginScreen
        self.window?.makeKeyAndVisible()
//        mainScreen = PodolistWireFrame.createPodolistModule()
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

//    func setupObserver() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(kakaoSessionDidChangeWithNotification),
//                                               name: NSNotification.Name.KOSessionDidChange,
//                                               object: nil)
//    }

//    @objc func kakaoSessionDidChangeWithNotification() {
//        reloadRootViewController()
//    }

//    fileprivate func reloadRootViewController() {
//        let isOpened = KOSession.shared().isOpen()
//        if !isOpened {
//            let mainScreen = self.mainScreen as! UINavigationController
//            mainScreen.popToRootViewController(animated: false)
//        }
//        self.window?.rootViewController = isOpened ? self.mainScreen : self.loginScreen
//        self.window?.rootViewController = self.loginScreen
//        self.window?.makeKeyAndVisible()
//    }
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

//extension AppDelegate /* For kakao */{
//
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        if KOSession.isKakaoAccountLoginCallback(url) {
//            return KOSession.handleOpen(url)
//        }
//        return true
//    }
//
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
//        if KOSession.isKakaoAccountLoginCallback(url) {
//            return KOSession.handleOpen(url)
//        }
//        return true
//    }
//}

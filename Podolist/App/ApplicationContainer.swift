//
//  ApplicationContainer.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Core
import Firebase
import KakaoOpenSDK
import Umbrella

struct AppDependency {
    let window: UIWindow
    let wireframe: AppWireframe
    let configureSDKs: () -> Void
    let configureAppearance: () -> Void
}

struct ApplicationContainer {
    static func resolve() -> AppDependency {
        let navigationController = UINavigationController()
        let window = UIWindow(frame: UIScreen.main.bounds).also {
            $0.rootViewController = navigationController
            $0.backgroundColor = .white
        }
        let wireFrame = AppWireframe(
            window: window,
            navigationController: navigationController
        )
        return AppDependency(
            window: window,
            wireframe: wireFrame,
            configureSDKs: configureSDKs,
            configureAppearance: configureAppearance
        )
    }

    static func configureSDKs() {
        configureModule()
        configureAnalytics()
        configureOAuth()
    }

    static func configureModule() {
        Core.setup()
    }

    static func configureAnalytics() {
        FirebaseApp.configure()
        analytics.register(provider: FirebaseProvider())
    }

    static func configureOAuth() {
        #if DEBUG
        #else
            let clientSecret = Bundle.main.infoDictionary?["KAKAO_CLIENT_SECRET"] as! String
            KOSession.shared()?.clientSecret = clientSecret
        #endif
    }

    static func configureAppearance() {
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}

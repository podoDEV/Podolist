//
//  AppInjector.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Firebase
import KakaoOpenSDK
import Swinject
import Umbrella

let container = Container()

struct AppDependency {
    let window: UIWindow
    let wireframe: AppWireframe
    let configureSDKs: () -> Void
    let configureAppearance: () -> Void
}

struct ApplicationInjector {
    static func resolve() -> AppDependency {
        let navigationController = UINavigationController()
        let window = UIWindow(frame: UIScreen.main.bounds).also {
            $0.rootViewController = navigationController
            $0.backgroundColor = .white
            $0.makeKeyAndVisible()
        }
        let wireFrame = AppWireframe(
            window: window,
            navigationController: navigationController
        )
        container
            .register(AuthNetworking.self) { _ in AuthNetworking(plugins: []) }
            .inObjectScope(.container)
        container
            .register(AuthServiceType.self) { r in
                let networking = r.resolve(AuthNetworking.self)!
                return AuthService(networking: networking)
            }
            .inObjectScope(.container)
        container
            .register(TodoNetworking.self) { r in
                let authService = r.resolve(AuthServiceType.self)!
                return TodoNetworking(plugins: [AuthPlugin(authService: authService)])
            }
            .inObjectScope(.container)
        container
            .register(MemberServiceType.self) { r in
                let networking = r.resolve(AuthNetworking.self)!
                return MemberService(networking: networking)
            }
            .inObjectScope(.container)
        container
            .register(TodoServiceType.self) { r in
                let networking = r.resolve(TodoNetworking.self)!
                return TodoService(networking: networking)
            }
            .inObjectScope(.container)
        return AppDependency(
            window: window,
            wireframe: wireFrame,
            configureSDKs: configureSDKs,
            configureAppearance: configureAppearance
        )
    }

    static func configureSDKs() {
        configureAnalytics()
        configureOAuth()
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
//        UINavigationBar.appearance().barStyle = .blackOpaque
    }
}

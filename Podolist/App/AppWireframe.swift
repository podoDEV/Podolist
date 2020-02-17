//
//  AppWireframe.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

class AppWireframe: BaseWireframe {
    var window: UIWindow
    var navigationController: UINavigationController

    init(
        window: UIWindow,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        window.rootViewController = navigationController
        guard let authService = container.resolve(AuthServiceType.self) else {
            fatalError("AuthServiceType not invoked")
        }
        var viewController: UIViewController
        if authService.current == nil {
            viewController = LoginWireFrame.createLoginModule()
        } else {
            viewController = TodolistWireFrame.createTodolistModule()
        }
        window.makeKeyAndVisible()
        show(viewController, with: .root(window: window))
    }
}

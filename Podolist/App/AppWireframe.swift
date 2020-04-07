//
//  AppWireframe.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Core

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
        var viewController: UIViewController
        if Core.authService.current == nil {
            viewController = LoginWireFrame.createLoginModule()
        } else {
            viewController = TodolistWireFrame.createTodolistModule()
        }
        window.makeKeyAndVisible()
        show(viewController, with: .root(window: window))
    }
}

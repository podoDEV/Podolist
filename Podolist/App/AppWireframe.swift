//
//  AppWireframe.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

class AppWireframe: BaseWireframe {
    static let shared = AppWireframe()
    private override init() { }

    weak var window: UIWindow!

    func setupKeyWindow(_ window: UIWindow, viewController: UIViewController) {
        self.window = window
        show(viewController, with: .root(window: window))
        window.makeKeyAndVisible()
    }
}

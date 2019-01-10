//
//  AppWireframe.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
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

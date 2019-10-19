//
//  LoginWireFrame.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol LoginWireFrameProtocol: class {
    // Presenter -> WireFrame
    func navigate(to route: LoginWireFrame.Router)
}

class LoginWireFrame: BaseWireframe, LoginWireFrameProtocol {
    enum Router {
        case todo
    }

    func navigate(to route: Router) {
        switch route {
        case .todo:
            showTodoView()
        }
    }

    func showTodoView() {
        let podolistViewController = PodolistWireFrame.createPodolistModule()
        show(podolistViewController, with: .root(window: UIApplication.shared.keyWindow!))
    }
}

extension LoginWireFrame {
    static func createLoginModule() -> LoginViewController {
        let authService = container.resolve(AuthServiceType.self)!
        let view = LoginViewController()
        let wireframe = LoginWireFrame()
        let interactor = LoginInteractor(
            authService: authService
        )
        let presenter = LoginPresenter(
            view: view,
            wireframe: wireframe,
            interactor: interactor
        )
        view.presenter = presenter
        interactor.presenter = presenter
        wireframe.view = view
        return view
    }
}

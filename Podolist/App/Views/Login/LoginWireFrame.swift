//
//  LoginWireFrame.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

protocol LoginWireFrameProtocol: class {
    static func createLoginModule() -> LoginViewController

    // Presenter -> WireFrame
    func navigate(to route: LoginWireFrame.Router)
}

class LoginWireFrame: BaseWireframe {
    enum Router {
        case todo
    }
}

extension LoginWireFrame: LoginWireFrameProtocol {

    static func createLoginModule() -> LoginViewController {

        // AccountDataSrouce
        let accountDataSource: AccountDataSource = AccountRepository()
        let accountLocalDataSource: AccountLocalDataSource = AccountLocalRepository()
        let accountRemoteDataSource: AccountRemoteDataSource = AccountRemoteRepository()

        accountDataSource.localDataSource = accountLocalDataSource
        accountDataSource.remoteDataSource = accountRemoteDataSource

        // CommonDataSrouce
        let commonDataSource: CommonDataSource = CommonRepository()
        let commonLocalDataSource: CommonLocalDataSource = CommonLocalRepository()
        let commonRemoteDataSource: CommonRemoteDataSource = CommonRemoteRepository()

        commonDataSource.localDataSource = commonLocalDataSource
        commonDataSource.remoteDataSource = commonRemoteDataSource

        let view = LoginViewController()
        let wireframe = LoginWireFrame()
        let interactor = LoginInteractor(accountDataSource: accountDataSource,
                                         commonDataSource: commonDataSource)
        let presenter = LoginPresenter(view: view,
                                       wireframe: wireframe,
                                       interactor: interactor)

        view.presenter = presenter
        wireframe.view = view
        return view
    }

    // MARK: - LoginWireFrameProtocol

    func navigate(to route: Router) {
        switch route {
        case .todo:
            showTodoView()
        }
    }
}

private extension LoginWireFrame {

    // MARK: - Navigation

    func showTodoView() {
        let podolistViewController = PodolistWireFrame.createPodolistModule()
        show(podolistViewController, with: .root(window: UIApplication.shared.keyWindow!))
    }
}

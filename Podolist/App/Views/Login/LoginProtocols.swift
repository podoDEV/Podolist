//
//  LoginProtocols.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }

    // Presenter -> View
    func showLogin()
}

extension LoginViewProtocol where Self: UIViewController {
    func showLoading() {

    }

    func hideLoading() {

    }
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }

    // View -> Presenter
    func viewDidLoad()
    func login(accessToken: AccessToken)
}

protocol LoginInteractorProtocol: class {
    var commonDataSource: CommonDataSource? { get set }
    var accountDataSource: AccountDataSource? { get set }

    // Presenter -> Interactor
    func hasSession() -> Completable?
    func makeSession(accessToken: AccessToken) -> Completable?
}

protocol LoginWireFrameProtocol: class {
    static func createLoginModule() -> UIViewController

    // Presenter -> WireFrame
    func goToPodolistScreen(from view: LoginViewProtocol)
}

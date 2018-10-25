//
//  LoginWireFrame.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class LoginWireFrame: LoginWireFrameProtocol {

    static var loginStoryboard: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: Bundle.main)
    }

    static func createLoginModule() -> UIViewController {
        let loginEntry = loginStoryboard.instantiateViewController(withIdentifier: EntryViewType.login.rawValue)
        if let view = loginEntry as? LoginView {
            let presenter: LoginPresenterProtocol = LoginPresenter()
            let interactor: LoginInteractorProtocol = LoginInteractor()
            let wireFrame: LoginWireFrameProtocol = LoginWireFrame()

            // CommonDataSrouce
            let commonDataSource: CommonDataSource = CommonRepository()
            let commonLocalDataSource: CommonLocalDataSource = CommonLocalRepository()
            let commonRemoteDataSource: CommonRemoteDataSource = CommonRemoteRepository()

            // AccountDataSrouce
            let accountDataSource: AccountDataSource = AccountRepository()
            let accountLocalDataSource: AccountLocalDataSource = AccountLocalRepository()
            let accountRemoteDataSource: AccountRemoteDataSource = AccountRemoteRepository()

            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.commonDataSource = commonDataSource
            interactor.accountDataSource = accountDataSource

            commonDataSource.localDataSource = commonLocalDataSource
            commonDataSource.remoteDataSource = commonRemoteDataSource

            accountDataSource.localDataSource = accountLocalDataSource
            accountDataSource.remoteDataSource = accountRemoteDataSource

            return loginEntry
        }
        return UIViewController()
    }

    func goToPodolistScreen(from view: LoginViewProtocol) {
        let destinationVC = PodolistWireFrame.createPodolistModule()
        UIApplication.shared.keyWindow?.rootViewController = destinationVC
    }
}

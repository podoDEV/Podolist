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

            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame

            return loginEntry
        }
        return UIViewController()
    }

    func goToPodolistScreen() {
        let destinationVC = PodolistWireFrame.createPodolistModule()
        UIApplication.shared.keyWindow?.rootViewController = destinationVC
    }
}

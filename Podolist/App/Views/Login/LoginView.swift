//
//  LoginView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Lifecycle
class LoginView: BaseViewController {
    var presenter: LoginPresenterProtocol?

    lazy var launchView: UIView! = {
        let view = Bundle.main.loadNibNamed("Launch", owner: self, options: nil)?.first as? UIView
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        showLoading()
    }

    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(launchView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        launchView.frame = view.bounds
    }
}

// MARK: - Action
extension LoginView {

    @IBAction func tappedLogin(_ sender: Any) {
        guard let session = KOSession.shared() else { return }
        if session.isOpen() {
            session.close()
        }

        session.open { error in
            guard session.isOpen() else {
                if let error = error as NSError? {
                    UIAlertController.showMessage(error.description)
                }
                return
            }

            self.presenter?.login(accessToken: AccessToken(id: session.token.accessToken))
        }
    }
}

extension LoginView: LoginViewProtocol {

    func showLogin() {
        launchView.removeFromSuperview()
        KOSession.shared().logoutAndClose { _, _ in }
    }

    func showError() {
        hideLoading()
    }
}

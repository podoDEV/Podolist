//
//  LoginView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

class LoginView: UIViewController {

    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        showLoading()
    }

    // MARK: - Action
    @IBAction func tappedLogin(_ sender: Any) {
        let session: KOSession = KOSession.shared()

        if session.isOpen() {
            session.close()
        }

        session.open(completionHandler: { (error) -> Void in

            if !session.isOpen() {
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        break
                    default:
                        UIAlertController.showMessage(error.description)
                    }
                }
            }
        })
    }
    @IBAction func backdoor(_ sender: Any) {
        presenter?.goLogin()
    }
}

extension LoginView: LoginViewProtocol {

    func showError() {
        hideLoading()
    }
}

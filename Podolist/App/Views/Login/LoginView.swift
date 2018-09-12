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
        presenter?.goLogin()
    }
}

extension LoginView: LoginViewProtocol {

    func showError() {
        hideLoading()
    }
}

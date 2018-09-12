//
//  LoginPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class LoginPresenter: LoginPresenterProtocol {
    var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var wireFrame: LoginWireFrameProtocol?

    let disposeBag = DisposeBag()

    func viewDidLoad() {

    }
}

extension LoginPresenter {
    func goLogin() {
        wireFrame?.goToPodolistScreen()
    }
}

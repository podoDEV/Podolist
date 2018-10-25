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
        interactor?.hasSession()!
            .observeOn(MainScheduler.instance)
            .subscribe { completable in
                switch completable {
                case .completed:
                    self.wireFrame?.goToPodolistScreen(from: self.view!)
                case .error:
                    self.view?.showLogin()
                }
            }.disposed(by: disposeBag)
    }

    func login(accessToken: AccessToken) {
        interactor?.makeSession(accessToken: accessToken)!
            .observeOn(MainScheduler.instance)
            .subscribe { completable in
                switch completable {
                case .completed:
                    self.wireFrame?.goToPodolistScreen(from: self.view!)
                case .error:
                    log.d("Invalid Session")
                    self.view?.showLogin()
                }
            }.disposed(by: disposeBag)
    }
}

extension LoginPresenter {
}

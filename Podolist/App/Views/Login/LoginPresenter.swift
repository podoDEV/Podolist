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
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe { completable in
                switch completable {
                case .completed:
                    self.wireFrame?.goToPodolistScreen(from: self.view!)
                case .error(let error):
                    self.view?.showLogin()
                }
            }.disposed(by: disposeBag)
    }

    func login(accessToken: Any) {
        interactor?.makeSession()!
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe { completable in
                switch completable {
                case .completed:
                    self.wireFrame?.goToPodolistScreen(from: self.view!)
                case .error(let error):
                    log.d("Invalid Session")
                    self.view?.showLogin()
                }
            }.disposed(by: disposeBag)
    }
}

extension LoginPresenter {
}

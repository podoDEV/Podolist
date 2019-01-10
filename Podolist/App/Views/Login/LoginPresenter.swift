//
//  LoginPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol LoginPresenterProtocol: class {
    // View -> Presenter
    func viewDidLoad()
    func didTapKakaoLogin()
    func didTapAnonymousLogin()
}

class LoginPresenter {

    // MARK: - Properties

    weak var view: LoginViewProtocol!
    private var wireframe: LoginWireFrameProtocol!
    private var interactor: LoginInteractorProtocol!

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(
        view: LoginViewProtocol,
        wireframe: LoginWireFrameProtocol,
        interactor: LoginInteractorProtocol
        ) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

// MARK: - LoginPresenterProtocol

extension LoginPresenter: LoginPresenterProtocol {

    func viewDidLoad() {
        sessionHandler(interactor.hasSession()!)
    }

    func didTapKakaoLogin() {
        sessionHandler(interactor.kakaoLogin())
    }

    func didTapAnonymousLogin() {
        sessionHandler(interactor.anonymousLogin())
    }
}

private extension LoginPresenter {

    func sessionHandler(_ completable: Completable) {
        completable
            .observeOn(MainScheduler.instance)
            .subscribe { completable in
                switch completable {
                case .completed:
                    self.wireframe.navigate(to: .todo)
                case .error:
                    self.view.showLogin()
                }
            }.disposed(by: disposeBag)
    }
}

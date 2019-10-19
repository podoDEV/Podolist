//
//  LoginPresenter.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

protocol LoginPresenterProtocol: AnyObject {
    // MARK: - View -> Presenter
    func didTapKakaoLogin()
    func didTapAnonymousLogin()

    // MARK: - Interactor -> Presenter
    func completeLogin()
}

class LoginPresenter {
    private weak let view: LoginViewProtocol?
    private let wireframe: LoginWireFrameProtocol
    private let interactor: LoginInteractorProtocol

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

extension LoginPresenter: LoginPresenterProtocol {
    func didTapKakaoLogin() {
        interactor.kakaoLogin()
    }

    func didTapAnonymousLogin() {
        interactor.anonymousLogin()
    }

    func completeLogin() {
        wireframe.navigate(to: .todo)
    }
}

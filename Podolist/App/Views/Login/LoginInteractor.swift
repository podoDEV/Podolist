//
//  LoginInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class LoginInteractor: LoginInteractorProtocol {

    var accountDataSource: AccountDataSource?
    var commonDataSource: CommonDataSource?

    func hasSession() -> Completable? {
        return commonDataSource?.hasSession()
    }

    func makeSession(accessToken: AccessToken) -> Completable? {
        return SessionService.shared.login(accessToken: accessToken)
            .debug()
            .flatMap { (self.accountDataSource?.addAccount($0))!.asObservable() }
            .asCompletable()
    }
}

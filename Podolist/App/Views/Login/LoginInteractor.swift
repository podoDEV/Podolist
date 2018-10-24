//
//  LoginInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class LoginInteractor: LoginInteractorProtocol {
    var dataSource: AccountDataSource?

    var accountDataSource: AccountDataSource?
    var commonDataSource: CommonDataSource?

    func hasSession() -> Completable? {
        return commonDataSource?.hasSession()
    }

    func makeSession(accessToken: AccessToken) -> Completable? {
        return AccountService.shared.login(accessToken: accessToken)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)).ignoreElements()
//            .flatMap { common }
    }

}

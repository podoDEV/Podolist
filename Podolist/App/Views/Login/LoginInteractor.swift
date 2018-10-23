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

    func login(accessToken: AccessToken) -> Observable<Account>? {
        return accountDataSource?.login(accessToken: accessToken)!
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func hasSession() -> Completable? {
        return commonDataSource?.hasSession()
    }
}

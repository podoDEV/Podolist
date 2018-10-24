//
//  AccountRemoteRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class AccountRemoteRepository: AccountRemoteDataSource {

    func login(accessToken: AccessToken) -> Observable<Account>? {
        return AccountService.shared.login(accessToken: accessToken)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .map { Account(responseAccount: $0) }
    }

    func logout() -> Completable? {
        return AccountService.shared.logout()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

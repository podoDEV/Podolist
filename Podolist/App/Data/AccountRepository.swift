//
//  AccountRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class AccountRepository: AccountDataSource {

    var localDataSource: AccountLocalDataSource?
    var remoteDataSource: AccountRemoteDataSource?

    func addAccount(_ account: Account) -> Completable? {
        return localDataSource?.insertAccount(account)
    }

//    func login(accessToken: AccessToken) -> Observable<Account>? {
//        return remoteDataSource?.login(accessToken: accessToken)
//    }
//
//    func logout() -> Completable? {
//        return remoteDataSource?.logout()
//    }
}

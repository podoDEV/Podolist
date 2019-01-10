//
//  AccountLocalRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class AccountLocalRepository: AccountLocalDataSource {

    func selectAccount() -> Account? {
        var account: Account?
        KeychainService.shared.findAccount(onCompleted: {
            account = $0
        })
        return account
    }

    func insertAccount(_ account: Account) -> Completable? {
        return Completable.create { completable in
            KeychainService.shared.save(account: account, onCompleted: {
                completable(.completed)
            }, onError: { error in
                completable(.error(error))
            })
            return Disposables.create {}
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

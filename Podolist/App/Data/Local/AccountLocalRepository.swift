//
//  AccountLocalRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class AccountLocalRepository: AccountLocalDataSource {

    func insertAccount(_ account: Account) -> Completable? {
        return Completable.create { completable in
            KeychainService.shared.saveValue(key: "me", value: String(account.id!), onCompleted: {
                completable(.completed)
            }, onError: { error in
                completable(.error(error))
            })
            return Disposables.create {}
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

//
//  CommonLocalRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class CommonLocalRepository: CommonLocalDataSource {

    func hasSession() -> Completable? {
        return Completable.create { completable in
            if KeychainService.shared.hasValue(key: "session") {
                completable(.completed)
            } else {
                completable(.error(NSError()))
            }
            return Disposables.create {}
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

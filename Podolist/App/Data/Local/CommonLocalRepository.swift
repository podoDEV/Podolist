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
            if KeychainService.shared.hasSession() {
                completable(.completed)
            } else {
                completable(.error(NSError()))
            }
            return Disposables.create {}
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func insertSession(_ session: Session) -> Completable? {
        return Completable.create { completable in
            KeychainService.shared.save(session: session, onCompleted: {
                completable(.completed)
            }, onError: { error in
                completable(.error(error))
            })
            return Disposables.create {}
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

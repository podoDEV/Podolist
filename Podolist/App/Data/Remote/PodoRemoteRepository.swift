//
//  PodoRemoteRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodoRemoteRepository: PodoRemoteDataSource {

    func getPodolist() -> Observable<[Podo]>? {
        return PodoService.sharedInstance.getAllPodolist()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map({ responsePodolist -> [Podo] in
                return responsePodolist.map { Podo(responsePodo: $0) }
            })
    }

    func getPodo(podoId: Int) -> Observable<Podo>? {
        return PodoService.sharedInstance.getPodo(podoId: podoId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map({ Podo(responsePodo: $0) })
    }

    func postPodo(_ podo: Podo) {

    }

    func putPodo() {

    }

    func deletePodo() {

    }
}

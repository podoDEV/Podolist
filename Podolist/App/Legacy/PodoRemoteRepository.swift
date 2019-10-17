//
//  PodoRemoteRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodoRemoteRepository: PodoRemoteDataSource {

    func getPodolist(page: Int, date: Date) -> Observable<Podolist>? {
        return PodoService.shared.getPodolist(page: page, date: date)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { responsePodolist -> Podolist in
                let delayedItems = responsePodolist.delayedItems.map { Podo(responsePodo: $0) }
                let items = responsePodolist.items.map { Podo(responsePodo: $0) }
                return Podolist(delayedItems: delayedItems, items: items)
            }
    }

    func getPodo(podoId: Int) -> Observable<Podo>? {
        return PodoService.shared.getPodo(podoId: podoId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { Podo(responsePodo: $0) }
    }

    func postPodo(_ podo: Podo) -> Observable<Podo>? {
        return PodoService.shared.postPodo(requestPodo: RequestPodo(podo: podo))
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { Podo(responsePodo: $0) }
    }

    func putPodo(id: Int, podo: Podo) -> Observable<Podo>? {
        return PodoService.shared.putPodo(id: id, requestPodo: RequestPodo(podo: podo))
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { Podo(responsePodo: $0) }
    }

    func deletePodo(id: Int) -> Completable? {
        return PodoService.shared.deletePodo(id: id)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

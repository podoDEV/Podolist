//
//  PodolistInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodolistInteractor: PodolistInteractorProtocol {
    var dataSource: PodoDataSource?

    func fetchPodolist() -> Observable<[ViewModelPodo]>? {
        return dataSource?.findPodolist()!
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { podolist -> [ViewModelPodo] in
                return podolist.map { ViewModelPodo(podo: $0) }
            }
    }

    func createPodo(podo: Podo) -> Completable? {
        return dataSource?.addPodo(podo)
    }
}

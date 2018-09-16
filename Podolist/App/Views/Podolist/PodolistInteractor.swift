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
            .flatMap({ podolist -> Observable<[ViewModelPodo]> in
                let viewModelPodolist: [ViewModelPodo] = podolist.map { ViewModelPodo(podo: $0) }
                return Observable.just(viewModelPodolist)
            })
    }
}

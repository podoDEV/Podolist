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
            .flatMap({
                Observable.just(Converter.convertToViewModelPodolist(with: $0))
            })
    }
}

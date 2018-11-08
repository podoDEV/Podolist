//
//  PodoRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodoRepository: PodoDataSource {
    var localDataSource: PodoLocalDataSource?
    var remoteDataSource: PodoRemoteDataSource?

    func findPodolist(page: Int, params: PodoParams) -> Observable<[Podo]>? {
        return remoteDataSource?.getPodolist(page: page, params: params)
    }

    func findPodo(podoId: Int) -> Observable<Podo>? {
        return remoteDataSource?.getPodo(podoId: podoId)
    }

    func addPodo(_ podo: Podo) -> Observable<Podo>? {
        return remoteDataSource?.postPodo(podo)
    }

    func savePodo(id: Int, podo: Podo) -> Observable<Podo>? {
        return remoteDataSource?.putPodo(id: id, podo: podo)
    }

    func removePodo(id: Int) -> Completable? {
        return remoteDataSource?.deletePodo(id: id)
    }
}

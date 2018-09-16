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

    func findPodolist() -> Observable<[Podo]>? {
        return remoteDataSource?.getPodolist()
    }

    func findPodo(podoId: Int) -> Observable<Podo>? {
        return remoteDataSource?.getPodo(podoId: podoId)
    }

    func addPodo(_ podo: Podo) {
        remoteDataSource?.postPodo(podo)
    }

    func savePodo(id: Int, title: String) {
        remoteDataSource?.putPodo()
    }

    func removePodo() {

    }
}

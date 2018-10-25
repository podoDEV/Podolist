//
//  CommonDataSource.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol CommonDataSource: class {
    var localDataSource: CommonLocalDataSource? { get set }
    var remoteDataSource: CommonRemoteDataSource? { get set }

    // Interactor -> DataSource
    func hasSession() -> Completable?
//    func saveSession() -> Completable?
}

protocol CommonLocalDataSource: class {
    // DataSource -> LocalDataSource
    func hasSession() -> Completable?
//    func selectPodolist() throws -> [Podo]
//    func insertPodo(_ podo: Podo) throws
//    func updatePodo()
//    func deletePodo()
}

protocol CommonRemoteDataSource: class {
    // DataSource -> RemoteDataSource
//    func getPodolist() -> Observable<[Podo]>?
//    func postPodo(_ podo: Podo)
//    func putPodo()
//    func deletePodo()
}

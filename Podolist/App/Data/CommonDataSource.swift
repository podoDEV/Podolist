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
    func findPodolist() -> Observable<[Podo]>?
    func addPodo(_ podo: Podo)
    func savePodo(id: Int, title: String)
    func removePodo()
}

protocol CommonLocalDataSource: class {
    // DataSource -> LocalDataSource
    func selectPodolist() throws -> [Podo]
    func insertPodo(_ podo: Podo) throws
    func updatePodo()
    func deletePodo()
}

protocol CommonRemoteDataSource: class {
    // DataSource -> RemoteDataSource
    func getPodolist() -> Observable<[Podo]>?
    func postPodo(_ podo: Podo)
    func putPodo()
    func deletePodo()
}

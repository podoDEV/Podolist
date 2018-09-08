//
//  PodoDataSource.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol PodoDataSource: class {
    var localDataSource: PodoLocalDataSource? { get set }
    var remoteDataSource: PodoRemoteDataSource? { get set }

    // Interactor -> DataSource
    func findPodolist() -> Observable<[Podo]>?
    func addPodo(_ podo: Podo)
    func savePodo(id: Int, title: String)
    func removePodo()
}

protocol PodoLocalDataSource: class {
    // DataSource -> LocalDataSource
    func selectPodolist() throws -> [Podo]
    func insertPodo(_ podo: Podo) throws
    func updatePodo()
    func deletePodo()
}

protocol PodoRemoteDataSource: class {
    // DataSource -> RemoteDataSource
    func getPodolist() -> Observable<[Podo]>?
    func postPodo(_ podo: Podo)
    func putPodo()
    func deletePodo()
}

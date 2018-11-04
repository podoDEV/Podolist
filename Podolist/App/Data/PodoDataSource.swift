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
    func findPodolist(page: Int, params: PodoParams) -> Observable<[Podo]>?
    func findPodolist() -> Observable<[Podo]>?
    func findPodo(podoId: Int) -> Observable<Podo>?
    func addPodo(_ podo: Podo) -> Observable<Podo>?
    func savePodo(id: Int, podo: Podo) -> Observable<Podo>?
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
    func getPodolist(page: Int, params: PodoParams) -> Observable<[Podo]>?
    func getPodolist() -> Observable<[Podo]>?
    func getPodo(podoId: Int) -> Observable<Podo>?
    func postPodo(_ podo: Podo) -> Observable<Podo>?
    func putPodo(id: Int, podo: Podo) -> Observable<Podo>?
    func deletePodo()
}

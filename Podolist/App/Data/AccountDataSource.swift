//
//  AccountDataSource.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol AccountDataSource: class {
    var localDataSource: AccountLocalDataSource? { get set }
    var remoteDataSource: AccountRemoteDataSource? { get set }

    // Interactor -> DataSource
    func login(accessToken: AccessToken) -> Observable<Account>?
    func logout() -> Completable?
//    func savePodo(id: Int, title: String)
//    func removePodo()
}

protocol AccountLocalDataSource: class {
    // DataSource -> LocalDataSource
//    func selectPodolist() throws -> [Podo]
//    func insertPodo(_ podo: Podo) throws
//    func updatePodo()
//    func deletePodo()
}

protocol AccountRemoteDataSource: class {
    // DataSource -> RemoteDataSource
    func login(accessToken: AccessToken) -> Observable<Account>?
    func logout() -> Completable?
}

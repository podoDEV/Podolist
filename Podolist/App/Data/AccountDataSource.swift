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
    func addAccount(_ account: Account) -> Completable?
}

protocol AccountLocalDataSource: class {
    // DataSource -> LocalDataSource
    func insertAccount(_ account: Account) -> Completable?
}

protocol AccountRemoteDataSource: class {
    // DataSource -> RemoteDataSource
//    func putAccount() -> Observable<Account>?
}

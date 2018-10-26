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
}

protocol CommonLocalDataSource: class {
    // DataSource -> LocalDataSource
    func hasSession() -> Completable?
}

protocol CommonRemoteDataSource: class {
    // DataSource -> RemoteDataSource

}

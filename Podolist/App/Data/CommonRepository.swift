//
//  CommonRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class CommonRepository: CommonDataSource {

    var localDataSource: CommonLocalDataSource?
    var remoteDataSource: CommonRemoteDataSource?

    func hasSession() -> Completable? {
        return localDataSource?.hasSession()
    }
}

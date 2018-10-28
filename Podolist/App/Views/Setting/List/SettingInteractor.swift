//
//  SettingInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class SettingInteractor: SettingInteractorProtocol {

    func removeSession() -> Completable? {
        return SessionService.shared.logout()
//            .flatMap { (self.accountDataSource?.addAccount($0))!.asObservable() }
//            .asCompletable()
    }
}

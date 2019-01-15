//
//  SettingInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol SettingInteractorProtocol: class {

    // Presenter -> Interactor
    var sections: [SettingSectionProtocol] { get }
    func removeSession() -> Completable?
}

class SettingInteractor: SettingInteractorProtocol {

    // MARK: - Properties

    private var accountDataSource: AccountDataSource

    let disposeBag = DisposeBag()

    lazy var sections: [SettingSectionProtocol] = setupSections()

    init(
        accountDataSource: AccountDataSource
        ) {
        self.accountDataSource = accountDataSource
    }

    func removeSession() -> Completable? {
        return SessionService.shared.logout()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .flatMap { (self.accountDataSource?.addAccount($0))!.asObservable() }
//            .asCompletable()
    }
}

private extension SettingInteractor {

    func setupSections() -> [SettingSectionProtocol] {
        let account: Account = accountDataSource.findAccount()!
        return [SettingInfoSection(rows: [SettingAccountRow(type: .account,
                                                            title: "",
                                                            image: account.profile,
                                                            name: account.name,
                                                            email: account.email),
                                          SettingRow(type: .about,
                                                     title: InterfaceString.Setting.About,
                                                     image: UIImage(named: "ic_about")!),
                                          SettingRow(type: .license,
                                                     title: InterfaceString.Setting.License,
                                                     image: UIImage(named: "ic_license")!)]),
                SettingOthersSection(rows: [SettingRow(type: .feedback,
                                                       title: InterfaceString.Setting.Feedback,
                                                       image: UIImage(named: "ic_sendFeedback")!)]),
                SettingLogoutSection(rows: [SettingRow(type: .logout,
                                                       title: InterfaceString.Setting.Logout,
                                                       image: UIImage(named: "ic_logout")!)])]
    }
}

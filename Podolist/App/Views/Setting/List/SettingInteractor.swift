//
//  SettingInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol SettingInteractorProtocol: class {
    //    var dataSource: PodoDataSource? { get set }

    // Presenter -> Interactor
    var sections: [SettingSectionProtocol] { get }
    func removeSession() -> Completable?
}

class SettingInteractor: SettingInteractorProtocol {

    lazy var sections: [SettingSectionProtocol] = setupSections()

    func setupSections() -> [SettingSectionProtocol] {
        return [SettingInfoSection(rows: [SettingRow(type: .account,
                                                     title: "Account",
                                                     image: UIImage(named: "ic_sendFeedback")),
                                          SettingRow(type: .about,
                                                     title: InterfaceString.Setting.About,
                                                     image: UIImage(named: "ic_sendFeedback")),
                                          SettingRow(type: .license,
                                                     title: InterfaceString.Setting.License,
                                                     image: UIImage(named: "ic_sendFeedback"))]),
                SettingOthersSection(rows: [SettingRow(type: .feedback,
                                                       title: InterfaceString.Setting.Feedback,
                                                       image: UIImage(named: "ic_sendFeedback"))]),
                SettingLogoutSection(rows: [SettingRow(type: .logout,
                                                       title: InterfaceString.Setting.Logout,
                                                       image: UIImage(named: "ic_logout"))])]
    }

    func removeSession() -> Completable? {
        return SessionService.shared.logout()
//            .flatMap { (self.accountDataSource?.addAccount($0))!.asObservable() }
//            .asCompletable()
    }
}

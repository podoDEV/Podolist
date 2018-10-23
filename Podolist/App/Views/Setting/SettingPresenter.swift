//
//  SettingPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class SettingPresenter: SettingPresenterProtocol {
    var view: SettingViewProtocol?
    var interactor: SettingInteractorProtocol?
    var wireFrame: SettingWireFrameProtocol?

    var items = [ViewModelSettingSection]()

    func viewDidLoad() {
        let accountItem = ViewModelSettingAccountItem(row: ViewModelSettingRow(type: .account, title: "계정", imageUrl: " "))
        items.append(accountItem)

        let othersItem = ViewModelSettingOthersItem(rows: [ViewModelSettingRow(type: .help, title: "도움말 및 피드백", imageUrl: " "),
                                                           ViewModelSettingRow(type: .about, title: "앱 정보", imageUrl: " "),
                                                           ViewModelSettingRow(type: .sync, title: "동기화", imageUrl: " ")])
        items.append(othersItem)

        let logoutItem = ViewModelSettingLogoutItem(row: ViewModelSettingRow(type: .logout, title: "로그아웃", imageUrl: " "))
        items.append(logoutItem)
        view?.showSettings(with: items)
    }
}

extension SettingPresenter {

    func showDetail(type: SettingRowType) {
        wireFrame?.goToDetailScreen(from: self.view!, to: type)
    }

    func logout() {
        KOSession.shared().logoutAndClose { success, error in

        }
    }
}

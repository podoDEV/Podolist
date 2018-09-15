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

    var items = [SettingViewModelItem]()

    func viewDidLoad() {
//        var settings: [Setting] = []
//        settings.append(Setting(title: "김"))
//        settings.append(Setting(title: "희범"))
//        settings.append(Setting(title: "쵝오"))
        let accountItem = SettingViewModelAccountItem(attribute: Attribute(type: .account, title: "계정", imageUrl: " "))
        items.append(accountItem)

        let othersItem = SettingViewModelOthersItem(attributes: [Attribute(type: .help, title: "도움말 및 피드백", imageUrl: " "),
                                                             Attribute(type: .about, title: "앱 정보", imageUrl: " "),
                                                             Attribute(type: .sync, title: "동기화", imageUrl: " ")])
        items.append(othersItem)

        let logoutItem = SettingViewModelLogoutItem(attribute: Attribute(type: .logout, title: "로그아웃", imageUrl: " "))
        items.append(logoutItem)
        view?.showSettings(with: items)
    }
}

extension SettingPresenter {

    func showAccount() {
        wireFrame?.goToAccountScreen(from: self.view!)
    }

    func showHelp() {
        wireFrame?.goToHelpScreen(from: self.view!)
    }

    func showAbout() {
        wireFrame?.goToAboutScreen(from: self.view!)
    }

    func logout() {
        KOSession.shared().logoutAndClose { success, error in

        }
    }
}

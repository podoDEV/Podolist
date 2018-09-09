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

    func viewDidLoad() {
        var settings: [Setting] = []
        settings.append(Setting(title: "김"))
        settings.append(Setting(title: "희범"))
        settings.append(Setting(title: "쵝오"))
        view?.showSettings(with: settings)
    }
}

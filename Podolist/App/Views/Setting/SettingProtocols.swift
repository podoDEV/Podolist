//
//  SettingProtocols.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift
import SwiftyJSON

protocol SettingViewProtocol: class {
    var presenter: SettingPresenterProtocol? { get set }

    // Presenter -> View 
    func showSettings(with settings: [SettingViewModelItem])
}

extension SettingViewProtocol where Self: UIViewController {
    func showLoading() {

    }

    func hideLoading() {

    }
}

protocol SettingPresenterProtocol: class {
    var view: SettingViewProtocol? { get set }
    var interactor: SettingInteractorProtocol? { get set }
    var wireFrame: SettingWireFrameProtocol? { get set }

    // View -> Presenter
    func viewDidLoad()
    func showAccount()
    func showHelp()
    func showAbout()
    func logout()
}

protocol SettingInteractorProtocol: class {
//    var dataSource: PodoDataSource? { get set }

    // Presenter -> Interactor
//    func fetchPodolist() -> Observable<[ViewModelPodo]>?
}

protocol SettingWireFrameProtocol: class {
    static func createSettingModule() -> UIViewController

    // Presenter -> WireFrame
    func goToAccountScreen(from view: SettingViewProtocol)
    func goToHelpScreen(from view: SettingViewProtocol)
    func goToAboutScreen(from view: SettingViewProtocol)
}

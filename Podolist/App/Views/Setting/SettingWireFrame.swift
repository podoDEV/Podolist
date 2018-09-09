//
//  SettingWireFrame.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class SettingWireFrame: SettingWireFrameProtocol {

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Setting", bundle: Bundle.main)
    }

    static func createSettingModule() -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "SettingController")
        if let view = controller as? SettingView {
            let presenter: SettingPresenterProtocol = SettingPresenter()
            let interactor: SettingInteractorProtocol = SettingInteractor()
//            let dataSource: PodoDataSource = PodoRepository()
//            let localDataSource: PodoLocalDataSource = PodoLocalRepository()
//            let remoteDataSource: PodoRemoteDataSource = PodoRemoteRepository()
            let wireFrame: SettingWireFrameProtocol = SettingWireFrame()

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
//            interactor.dataSource = dataSource
//            dataSource.localDataSource = localDataSource
//            dataSource.remoteDataSource = remoteDataSource

            return controller
        }
        return UIViewController()
    }
}

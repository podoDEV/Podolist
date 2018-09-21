//
//  PodolistWireFrame.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodolistWireFrame: PodolistWireFrameProtocol {

    static var podolistStoryboard: UIStoryboard {
        return UIStoryboard(name: "Podolist", bundle: Bundle.main)
    }

    static func createPodolistModule() -> UIViewController {
        let podolistEntry = podolistStoryboard.instantiateViewController(withIdentifier: EntryViewType.podolist.rawValue)
        if let view = podolistEntry.childViewControllers.first as? PodolistView {
            let presenter: PodolistPresenterProtocol = PodolistPresenter()
            let interactor: PodolistInteractorProtocol = PodolistInteractor()
            let dataSource: PodoDataSource = PodoRepository()
            let localDataSource: PodoLocalDataSource = PodoLocalRepository()
            let remoteDataSource: PodoRemoteDataSource = PodoRemoteRepository()
            let wireFrame: PodolistWireFrameProtocol = PodolistWireFrame()

            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.dataSource = dataSource
            dataSource.localDataSource = localDataSource
            dataSource.remoteDataSource = remoteDataSource

            return podolistEntry
        }
        return UIViewController()
    }

    func goToSettingScreen(from view: PodolistViewProtocol) {
        guard let sourceVC = view as? UIViewController else {
            return
        }
        let destinationVC = SettingWireFrame.createSettingModule()
        sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

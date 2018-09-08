//
//  PodolistWireFrame.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodolistWireFrame: PodolistWireFrameProtocol {

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Podolist", bundle: Bundle.main)
    }

    static func createPodolistModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PodolistNavigationController")
        if let view = navController.childViewControllers.first as? PodolistView {
            let presenter: PodolistPresenterProtocol = PodolistPresenter()
            let interactor: PodolistInteractorProtocol = PodolistInteractor()
            let dataSource: PodoDataSource = PodoRepository()
            let localDataSource: PodoLocalDataSource = PodoLocalRepository()
            let remoteDataSource: PodoRemoteDataSource = PodoRemoteRepository()
            let wireFrame: PodolistWireFrameProtocol = PodolistWireFrame()

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.dataSource = dataSource
            dataSource.localDataSource = localDataSource
            dataSource.remoteDataSource = remoteDataSource

            return navController
        }
        return UIViewController()
    }
}

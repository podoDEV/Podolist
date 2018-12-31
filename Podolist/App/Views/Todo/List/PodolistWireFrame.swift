//
//  PodolistWireFrame.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

protocol PodolistWireFrameProtocol: class {
    static func createPodolistModule() -> UINavigationController

    // Presenter -> WireFrame
    func navigate(to route: PodolistWireFrame.Router)
}

class PodolistWireFrame: BaseWireframe {
    enum Router {
        case setting
    }
}

extension PodolistWireFrame: PodolistWireFrameProtocol {

    static func createPodolistModule() -> UINavigationController {

        // PodoDataSource
        let podoDataSource: PodoDataSource = PodoRepository()
        let podoLocalDataSource: PodoLocalDataSource = PodoLocalRepository()
        let podoRemoteDataSource: PodoRemoteDataSource = PodoRemoteRepository()

        podoDataSource.localDataSource = podoLocalDataSource
        podoDataSource.remoteDataSource = podoRemoteDataSource

        // AccountDataSrouce
        let accountDataSource: AccountDataSource = AccountRepository()
        let accountLocalDataSource: AccountLocalDataSource = AccountLocalRepository()
        let accountRemoteDataSource: AccountRemoteDataSource = AccountRemoteRepository()

        accountDataSource.localDataSource = accountLocalDataSource
        accountDataSource.remoteDataSource = accountRemoteDataSource

        let view = PodolistViewController()
        let wireframe = PodolistWireFrame()
        let interactor = PodolistInteractor(podoDataSource: podoDataSource,
                                            accountDataSource: accountDataSource)
        let presenter = PodolistPresenter(view: view,
                                          wireframe: wireframe,
                                          interactor: interactor)
        view.presenter = presenter
        wireframe.view = view

        return UINavigationController(rootViewController: view)
    }

    // MARK: - PodolistWireFrameProtocol

    func navigate(to route: Router) {
        switch route {
        case .setting:
            showSettingView()
        }
    }
}

private extension PodolistWireFrame {

    // MARK: - Navigation

    func showSettingView() {
        let settingViewController = SettingWireFrame.createSettingModule()
        show(settingViewController, with: .push)
    }
}

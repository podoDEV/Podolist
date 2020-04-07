//
//  TodolistWireFrame.swift
//  Podolist
//
//  Created by hb1love on 2019/10/20.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Core

protocol TodolistWireFrameProtocol {
    // MARK: - Presenter -> WireFrame
    func navigate(to route: TodolistWireFrame.Router)
}

class TodolistWireFrame: BaseWireframe {
    enum Router {
        case setting
    }

    func navigate(to route: Router) {
        switch route {
        case .setting:
            showSettingView()
        }
    }

    func showSettingView() {
        let settingViewController = SettingWireFrame.createSettingModule()
        show(settingViewController, with: .push)
    }
}

extension TodolistWireFrame: TodolistWireFrameProtocol {
    static func createTodolistModule() -> UINavigationController {
        let todoService = Core.todoService
        let view = TodolistViewController()
        let wireframe = TodolistWireFrame()
        let interactor = TodolistInteractor(todoService: todoService)
        let presenter = TodolistPresenter(
            view: view,
            wireframe: wireframe,
            interactor: interactor
        )
        view.presenter = presenter
        interactor.presenter = presenter
        wireframe.view = view

        return UINavigationController(rootViewController: view)
    }
}

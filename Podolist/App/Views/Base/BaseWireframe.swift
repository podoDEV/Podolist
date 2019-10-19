//
//  BaseWireframe.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

class BaseWireframe: NSObject {
    weak var view: UIViewController!

    func show(_ viewController: UIViewController, with type: TransitionType, animated: Bool = true) {
        DispatchQueue.main.async {
            switch type {
            case .push:
                guard let navigationController = view.navigationController else {
                    fatalError("Can't push without a navigation controller")
                }
                navigationController.pushViewController(viewController, animated: animated)
            case .present(let sender):
                sender.present(viewController, animated: animated)
            case .root(let window):
                window.rootViewController = viewController
            }
        }
    }

    func pop(isModal: Bool = false, animated: Bool = true) {
        DispatchQueue.main.async {
            if let navigationController = view.navigationController {
                if isModal {
                    navigationController.dismiss(animated: animated, completion: nil)
                } else if navigationController.popViewController(animated: animated) == nil {
                    if let presentingView = view.presentingViewController {
                        return presentingView.dismiss(animated: animated)
                    } else {
                        fatalError("Can't navigate back from \(view!)")
                    }
                }
            } else if let presentingView = view.presentingViewController {
                presentingView.dismiss(animated: animated)
            } else {
                fatalError("Neither modal nor navigation! Can't navigate back from \(view!)")
            }
        }
    }
}

extension BaseWireframe {

    func presentAlert(title: String,
                      message: String,
                      preferredStyle: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: InterfaceString.Commmon.OK, style: .default, handler: nil)
        alertController.addAction(okAction)
        show(alertController, with: .present(from: view))
    }

    func presentActionSheet(title: String? = nil,
                            message: String? = nil,
                            actionTitle: String,
                            handler: ((UIAlertAction) -> Void)? = nil,
                            preferredStyle: UIAlertController.Style = .actionSheet) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let userAction = UIAlertAction(title: actionTitle, style: .destructive, handler: handler)
        let cancelAction = UIAlertAction(title: InterfaceString.Commmon.Cancel, style: .cancel, handler: nil)
        alertController.addAction(userAction)
        alertController.addAction(cancelAction)
        show(alertController, with: .present(from: view))
    }
}

enum TransitionType {
    case root(window: UIWindow)
    case push
    case present(from: UIViewController)
}

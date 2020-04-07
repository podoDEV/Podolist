//
//  SettingWireFrame.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import MessageUI
import Core

protocol SettingWireFrameProtocol {
    // Presenter -> WireFrame
    func navigate(to route: SettingWireFrame.Router)
}

class SettingWireFrame: BaseWireframe, SettingWireFrameProtocol {
    enum Router {
        case about
        case license
        case login
        case feedback(recipients: [String], subject: String, message: String)
        case action(title: String?, message: String?, actionTitle: String, handler: ((UIAlertAction) -> Void)?)
        case alert(title: String, message: String)
    }

    func navigate(to route: Router) {
        switch route {
        case .about:
            showAboutView()
        case .license:
            showLicenseView()
        case .login:
            showLoginView()
        case .feedback(let recipients, let subject, let message):
            showFeedbackView(
                recipients: recipients,
                subject: subject,
                message: message
            )
        case .action(let title, let message, let actionTitle, let handler):
            presentActionSheet(
                title: title,
                message: message,
                actionTitle: actionTitle,
                handler: handler
            )
        case .alert(let title, let message):
            presentAlert(title: title, message: message)
        }
    }

    func showAboutView() {
        let aboutViewController = AboutViewController()
        show(aboutViewController, with: .push)
    }

    func showLicenseView() {
        let licenseViewController = LicenseViewController()
        show(licenseViewController, with: .push)
    }

    func showLoginView() {
        let loginViewController = LoginWireFrame.createLoginModule()
        show(loginViewController, with: .root(window: UIApplication.shared.keyWindow!))
    }

    func showFeedbackView(recipients: [String], subject: String, message: String) {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(recipients)
        mailComposer.setSubject(subject)
        mailComposer.setMessageBody(message, isHTML: false)
        mailComposer.modalPresentationStyle = .currentContext
        show(mailComposer, with: .present(from: view))
    }
}

extension SettingWireFrame: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        pop(isModal: true, animated: true)
    }
}

extension SettingWireFrame {
    static func createSettingModule() -> SettingViewController {
        let authService = Core.authService
        let memberService = Core.memberService
        let view = SettingViewController()
        let wireframe = SettingWireFrame()
        let interactor = SettingInteractor(
            authService: authService,
            memberService: memberService
        )
        let presenter = SettingPresenter(
            view: view,
            wireframe: wireframe,
            interactor: interactor
        )
        view.presenter = presenter
        interactor.presenter = presenter
        wireframe.view = view
        return view
    }
}

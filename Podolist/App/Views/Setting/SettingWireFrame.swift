//
//  SettingWireFrame.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import MessageUI

protocol SettingWireFrameProtocol: class {
    static func createSettingModule() -> SettingViewController

    // Presenter -> WireFrame
    func navigate(to route: SettingWireFrame.Router)
}

class SettingWireFrame: BaseWireframe {
    enum Router {
        case about
        case license
        case feedback(recipients: [String], subject: String, message: String)
        case logout
        case action(title: String?, message: String?, actionTitle: String, handler: ((UIAlertAction) -> Void)?)
        case alert(title: String, message: String)
    }
}

extension SettingWireFrame: SettingWireFrameProtocol {

    static func createSettingModule() -> SettingViewController {

        // AccountDataSrouce
        let accountDataSource: AccountDataSource = AccountRepository()
        let accountLocalDataSource: AccountLocalDataSource = AccountLocalRepository()
        let accountRemoteDataSource: AccountRemoteDataSource = AccountRemoteRepository()

        accountDataSource.localDataSource = accountLocalDataSource
        accountDataSource.remoteDataSource = accountRemoteDataSource

        let view = SettingViewController()
        let wireframe = SettingWireFrame()
        let interactor = SettingInteractor(accountDataSource: accountDataSource)
        let presenter = SettingPresenter(view: view,
                                         wireframe: wireframe,
                                         interactor: interactor)

        view.presenter = presenter
        wireframe.view = view
        return view
    }

    // MARK: - SettingWireFrameProtocol

    func navigate(to route: Router) {
        switch route {
        case .about:
            showAboutView()
        case .license:
            showLicenseView()
        case .feedback(let recipients, let subject, let message):
            showFeedbackView(recipients: recipients, subject: subject, message: message)
        case .logout:
            showLoginView()
        case .action(let title, let message, let actionTitle, let handler):
            presentActionSheet(title: title,
                               message: message,
                               actionTitle: actionTitle,
                               handler: handler)
        case .alert(let title, let message):
            presentAlert(title: title, message: message)
            return
        }
    }
}

private extension SettingWireFrame {

    // MARK: - Navigation

    func showAboutView() {
        let aboutViewController = AboutViewController()
        show(aboutViewController, with: .push)
    }

    func showLicenseView() {
        let licenseViewController = LicenseViewController()
        show(licenseViewController, with: .push)
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

    func showLoginView() {
        let loginViewController = LoginWireFrame.createLoginModule()
        show(loginViewController, with: .root(window: UIApplication.shared.keyWindow!))
    }
}

extension SettingWireFrame: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        pop(isModal: true, animated: true)
    }
}

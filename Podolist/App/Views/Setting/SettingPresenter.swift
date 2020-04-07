//
//  SettingPresenter.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import MessageUI
import Core

protocol SettingPresenterProtocol: AnyObject {
    // MARK: - View -> Presenter
    var rows: [SettingRowProtocol] { get }
    func viewDidLoad()
    func numberOfRows(in section: Int) -> Int
    func didSelectRow(at indexPath: IndexPath)
    func configureCell(_ cell: SettingCellType, forRowAt indexPath: IndexPath)

    // MARK: - Interactor -> Presenter
    func didFetchRows(rows: [SettingRowProtocol])
    func completeLogout()
}

final class SettingPresenter: SettingPresenterProtocol {
    private weak var view: SettingViewProtocol?
    private let interactor: SettingInteractorProtocol
    private let wireFrame: SettingWireFrameProtocol

    var rows: [SettingRowProtocol] = []

    init(
        view: SettingViewProtocol,
        wireframe: SettingWireFrameProtocol,
        interactor: SettingInteractorProtocol
    ) {
        self.view = view
        self.wireFrame = wireframe
        self.interactor = interactor
    }
}

// MARK: - View -> Presenter
extension SettingPresenter {
    func viewDidLoad() {
        interactor.fetchSections()
    }

    func numberOfRows(in section: Int) -> Int {
        return rows.count
    }

    func didSelectRow(at indexPath: IndexPath) {
        let item = rows[indexPath.row]
        switch item.type {
        case .account:
            break
        case .about:
            wireFrame.navigate(to: .about)
        case .license:
            wireFrame.navigate(to: .license)
        case .feedback:
            if MFMailComposeViewController.canSendMail() {
                wireFrame.navigate(
                    to: .feedback(
                        recipients: ["podo.devops@gmail.com", "heebuma@gmail.com"],
                        subject: "[Feedback] ",
                        message: getInfo()
                    )
                )
            } else {
                wireFrame.navigate(
                    to: .alert(
                        title: "error.email.title".localized,
                        message: "error.email.body".localized
                    )
                )
            }
        case .logout:
            wireFrame.navigate(
                to: .action(
                    title: nil,
                    message: nil,
                    actionTitle: "setting.logout".localized
                ) { _ in
                    analytics.log(.logout)
                    self.interactor.logout()
                }
            )
        }
    }

    func configureCell(_ cell: SettingCellType, forRowAt indexPath: IndexPath) {
        cell.configure(with: rows[indexPath.row])
    }
}

// MARK: - Interactor -> Presenter
extension SettingPresenter {
    func didFetchRows(rows: [SettingRowProtocol]) {
        self.rows = rows
        view?.reloadData()
    }

    func completeLogout() {
        wireFrame.navigate(to: .login)
    }
}

private extension SettingPresenter {
    func getInfo() -> String {
        return """
        \n\n\n\n
        ---------------------------------
        My App: \("common.podolist".localized)
        My Version: \(AppUtils.AppVersion)(\(AppUtils.AppBuildVersion))
        My iOS: \(AppUtils.iOSVersion)
        ---------------------------------
        """
    }
}

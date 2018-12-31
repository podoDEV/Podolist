//
//  SettingPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift
import MessageUI

protocol SettingPresenterProtocol: class {
    // View -> Presenter
    var sections: [SettingSectionProtocol] { get }
    func numberOfRows(in section: Int) -> Int
    func didSelectRow(at indexPath: IndexPath)
    func configureCell(_ cell: SettingCellType, forRowAt indexPath: IndexPath)
}

final class SettingPresenter {

    // MARK: - Properties

    private var view: SettingViewProtocol!
    private var interactor: SettingInteractorProtocol!
    private var wireFrame: SettingWireFrameProtocol!

    lazy var sections = interactor.sections
    let disposeBag = DisposeBag()

    // MARK: - Initializer

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

// MARK: - SettingPresenterProtocol

extension SettingPresenter: SettingPresenterProtocol {

    func numberOfRows(in section: Int) -> Int {
        return sections[section].rowCount
    }

    func didSelectRow(at indexPath: IndexPath) {
        let item = sections[indexPath.section].rows[indexPath.row]
        switch item.type {
        case .account:
            break
        case .about:
            wireFrame.navigate(to: .about)
        case .license:
            wireFrame.navigate(to: .license)
        case .feedback:
            guard MFMailComposeViewController.canSendMail() else {
                wireFrame.navigate(to: .alert(title: InterfaceString.Error.MailTitle,
                                              message: InterfaceString.Error.MailBody))
                return
            }
            wireFrame.navigate(to: .feedback(recipients: InterfaceString.Commmon.Developers,
                                             subject: InterfaceString.Commmon.Subject,
                                             message: InterfaceString.Commmon.Info))
        case .logout:
            wireFrame.navigate(to: .action(title: nil,
                                           message: nil,
                                           actionTitle: InterfaceString.Setting.Logout) { _ in
                                            self.logout()
                })
        }
    }

    func configureCell(_ cell: SettingCellType, forRowAt indexPath: IndexPath) {
        cell.configureWith(sections[indexPath.section].rows[indexPath.row])
    }
}

private extension SettingPresenter {

    func logout() {
        KOSession.shared().logoutAndClose { _, _ in}
        interactor?.removeSession()!
            .observeOn(MainScheduler.instance)
            .subscribe { completable in
                switch completable {
                case .completed:
                    self.wireFrame.navigate(to: .logout)
                case .error:
                    log.d("Invalid Session")
                }
            }.disposed(by: disposeBag)
    }
}

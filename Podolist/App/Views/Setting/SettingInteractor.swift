//
//  SettingInteractor.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import Core

protocol SettingInteractorProtocol: AnyObject {
    // MARK: - Presenter -> Interactor
    func fetchSections()
    func logout()
}

class SettingInteractor: SettingInteractorProtocol {
    weak var presenter: SettingPresenterProtocol?
    private var authService: AuthServiceType
    private var memberService: MemberServiceType

    init(authService: AuthServiceType, memberService: MemberServiceType) {
        self.authService = authService
        self.memberService = memberService
    }
}

// MARK: - Presenter -> Interactor

extension SettingInteractor {
    func fetchSections() {
        self.presenter?.didFetchRows(rows: self.makeSection())
    }

    func logout() {
        KOSession.shared().logoutAndClose { _, _ in }
        authService.logout()
        presenter?.completeLogout()
    }
}

private extension SettingInteractor {
    func makeSection() -> [SettingRowProtocol] {
        return [
            makeAboutRow(),
            makeLicenseRow(),
            makeFeedbackRow(),
            makeLogoutRow()
        ]
    }

    func makeAccountRow(account: Account) -> SettingAccountRow {
        return SettingAccountRow(
            type: .account,
            title: "",
            name: account.name ?? "",
            email: account.email,
            imageUrl: account.profileImageUrl
        )
    }

    func makeAboutRow() -> SettingRow {
        return SettingRow(
            type: .about,
            title: "setting.about".localized
        )
    }

    func makeLicenseRow() -> SettingRow {
        return SettingRow(
            type: .license,
            title: "setting.license".localized
        )
    }

    func makeFeedbackRow() -> SettingRow {
        return SettingRow(
            type: .feedback,
            title: "setting.feedback".localized
        )
    }

    func makeLogoutRow() -> SettingRow {
        return SettingRow(
            type: .logout,
            title: "setting.logout".localized
        )
    }
}

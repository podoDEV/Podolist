//
//  SettingInteractor.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

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
//        memberService.me { [weak self] result in
//            guard let `self` = self else { return }
//            switch result {
//            case .success(let account):
//                let rows = self.makeSection(account: account)
//                self.presenter?.didFetchRows(rows: rows)
//            case .failure:
//                break
//            }
//        }
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

//    func makeSection(account: Account) -> [SettingRowProtocol] {
//        return [
//            makeSettingAccountRow(account: account),
//            makeAboutRow(),
//            makeLicenseRow(),
//            makeFeedbackRow(),
//            makeLogoutRow()
//        ]
//    }

    func makeAccountRow(account: Account) -> SettingAccountRow {
        return SettingAccountRow(
            type: .account,
            title: "",
            image: nil,
            name: account.name ?? "",
            email: account.email,
            imageUrl: account.profileImageUrl
        )
    }

    func makeAboutRow() -> SettingRow {
        return SettingRow(
            type: .about,
            title: "setting.about".localized,
            image: UIImage(named: "ic_about")!
        )
    }

    func makeLicenseRow() -> SettingRow {
        return SettingRow(
            type: .license,
            title: "setting.license".localized,
            image: UIImage(named: "ic_license")!
        )
    }

    func makeFeedbackRow() -> SettingRow {
        return SettingRow(
            type: .feedback,
            title: "setting.feedback".localized,
            image: UIImage(named: "ic_sendFeedback")!
        )
    }

    func makeLogoutRow() -> SettingRow {
        return SettingRow(
            type: .logout,
            title: "setting.logout".localized,
            image: UIImage(named: "ic_logout")!
        )
    }
}

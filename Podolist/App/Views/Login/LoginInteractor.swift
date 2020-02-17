//
//  LoginInteractor.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

protocol LoginInteractorProtocol: class {
    // MARK: - Presenter -> Interactor
    func kakaoLogin()
    func anonymousLogin()
}

class LoginInteractor {
    weak var presenter: LoginPresenterProtocol?
    private let authService: AuthServiceType

    init(authService: AuthServiceType) {
        self.authService = authService
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    func kakaoLogin() {
        getkakaoSession { [weak self] token in
            guard let token = token else { return }
            let provider = AuthProvider.kakao(token)
            self?.authService.authorize(provider) { result in
                switch result {
                case .success:
                    analytics.log(.login(provider))
                    self?.presenter?.completeLogin()
                case .failure:
                    break
                }
            }
        }
    }

    func anonymousLogin() {
        let uuid = getUUID()
        let provider = AuthProvider.anonymous(uuid)
        authService.authorize(provider) { [weak self] result in
            switch result {
            case .success:
                analytics.log(.login(provider))
                self?.presenter?.completeLogin()
            case .failure:
                break
            }
        }
    }
}

private extension LoginInteractor {
    func getkakaoSession(_ completion: @escaping (String?) -> Void) {
        guard let session = KOSession.shared() else {
            completion(nil)
            log.d("Invalid kakao session")
            return
        }

        if session.isOpen() {
            session.close()
        }

        session.open { error in
            guard session.isOpen() else {
                log.d("Invalid kakao state")
                completion(nil)
                return
            }
            completion(session.token.accessToken)
        }
    }

    func getUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}

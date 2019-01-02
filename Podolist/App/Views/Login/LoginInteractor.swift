//
//  LoginInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol LoginInteractorProtocol: class {
    // Presenter -> Interactor
    func hasSession() -> Completable?
    func kakaoLogin() -> Completable
    func anonymousLogin() -> Completable
}

class LoginInteractor {

    // MARK: - Properties

    private var accountDataSource: AccountDataSource
    private var commonDataSource: CommonDataSource

    let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(
        accountDataSource: AccountDataSource,
        commonDataSource: CommonDataSource
        ) {
        self.accountDataSource = accountDataSource
        self.commonDataSource = commonDataSource
    }
}

// MARK: - LoginInteractorProtocol

extension LoginInteractor: LoginInteractorProtocol {

    func hasSession() -> Completable? {
        return commonDataSource.hasSession()
    }

    func kakaoLogin() -> Completable {
        return Completable.create { completable in
            self.getkakaoSession { [weak self] token in
                guard let `self` = self else { return }
                guard let token = token else { return }
                SessionService.shared.login(provider: .kakao(token))
                    .flatMapLatest { login -> Completable in
                        let session = login.session
                        let responseAccount = login.responseAccount
                        var profile: UIImage
                        if let url = URL(string: (responseAccount?.imageUrl)!),
                            let data = try? Data(contentsOf: url),
                            let image = UIImage(data: data) {
                            profile = image
                        } else {
                            profile = UIImage(named: "ic_profile")!
                        }
                        let account = Account(responseAccount: responseAccount!, profile: profile)
                        log.d(account.name)
                        return Completable.merge(self.commonDataSource.addSession(session!)!,
                                                 self.accountDataSource.addAccount(account)!)
                    }.subscribe { observer in
                        switch observer {
                        case .completed:
                            completable(.completed)
                        case .error(let error):
                            completable(.error(error))
                        }
                    }.disposed(by: self.disposeBag)
            }
            return Disposables.create {}
        }
    }

    func anonymousLogin() -> Completable {
        return Completable.create { completable in
            self.getUUID { [weak self] uuid in
                guard let `self` = self else { return }
                SessionService.shared.login(provider: .anonymous(uuid))
                    .flatMapLatest { login -> Completable in
                        let session = login.session
                        let responseAccount = login.responseAccount
                        let profile = UIImage(named: "ic_profile")!
                        let account = Account(responseAccount: responseAccount!, profile: profile)
                        log.d(account.name)
                        return Completable.merge(self.commonDataSource.addSession(session!)!,
                                                 self.accountDataSource.addAccount(account)!)
                    }.subscribe { observer in
                        switch observer {
                        case .completed:
                            completable(.completed)
                        case .error(let error):
                            completable(.error(error))
                        }
                    }.disposed(by: self.disposeBag)
            }
            return Disposables.create {}
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

    func getUUID(_ completion: @escaping (String) -> Void) {
        if let uuid = UserDefaults.standard.string(forKey: "uuid") {
            completion(uuid)
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.setValue(uuid, forKey: "uuid")
            completion(uuid)
        }
    }
}

//
//  AccountService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

protocol SessionServiceProtocol: ApiServiceProtocol {

    func login(accessToken: AccessToken) -> Observable<Account>
    func logout() -> Completable
}

class SessionService: SessionServiceProtocol {
    static let shared = SessionService()
//    var sessionService: ApiSessionService
//    private init() {
//        sessionService = ApiSessionService.shared
//    }

    func login(accessToken: AccessToken) -> Observable<Account> {
        return Observable<Account>.create { observer in
            let request = Alamofire.request(Router.Login.create(parameters: accessToken.asDicsionary))
                .validate()
                .responseJSON { response in
                    KeychainService.shared.saveValue(key: "session", value: response.response?.allHeaderFields["Set-Cookie"] as! String)
                    switch response.result {
                    case .success(let value):
                        guard let account = JSON(value).to(type: Account.self) as? Account else {
                            observer.onError(NSError())
                            return
                        }
                        observer.onNext(account)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            request.resume()
            return Disposables.create {
                request.cancel()
            }
        }
    }

    func logout() -> Completable {
        return Completable.create { completable in
            let request = Alamofire.request(Router.Logout.create())
                .validate()
                .responseData { response in
                    KeychainService.shared.deleteValue(key: "session")
                    switch response.result {
                    case .success:
                        completable(.completed)
                    case .failure(let error):
                        completable(.error(error))
                    }
                }
            request.resume()
            return Disposables.create {}
        }
    }
}

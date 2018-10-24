//
//  AccountService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

protocol AccountServiceProtocol: ApiServiceProtocol {

    func login(accessToken: AccessToken) -> Observable<Account>
    func logout() -> Completable
}

class AccountService: AccountServiceProtocol {
    static let shared = AccountService()
//    var sessionService: ApiSessionService
//    private init() {
//        sessionService = ApiSessionService.shared
//    }

    func login(accessToken: AccessToken) -> Observable<Account> {
        return Observable<Account>.create { observer in
            let request = Alamofire.request(Router.Login.create(parameters: accessToken.asDicsionary))
                .validate()
                .responseJSON { response in
                    KeychainService.shared.saveToken(token: response.response?.allHeaderFields["Set-Cookie"] as! String)
                    switch response.result {
                    case .success(let value):
                        guard let account = JSON(value).to(type: Account.self) as? Account else {
//                        guard let responseAccount = JSON(value).to(type: ResponseAccount.self) as? ResponseAccount else {
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
                    switch response.result {
                    case .success(_):
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

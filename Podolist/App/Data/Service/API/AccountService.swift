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

    func login(accessToken: AccessToken) -> Observable<ResponseAccount>
    func logout() -> Completable
}

class AccountService: AccountServiceProtocol {
    static let shared = AccountService()
    var sessionService: ApiSessionService
    private init() {
        sessionService = ApiSessionService.shared
    }

    func login(accessToken: AccessToken) -> Observable<ResponseAccount> {
        return Observable<ResponseAccount>.create { observer in
            let request = self.sessionService.api().request(Router.Login.create(parameters: accessToken.asDicsionary))
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard let responseAccount = JSON(value).to(type: ResponseAccount.self) as? ResponseAccount else {
                            observer.onError(NSError())
                            return
                        }
                        observer.onNext(responseAccount)
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
            let request = self.sessionService.api().request(Router.Logout.create())
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

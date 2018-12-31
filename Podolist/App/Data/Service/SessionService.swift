//
//  SessionService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

protocol SessionServiceProtocol: ApiServiceProtocol {

    func login(provider: AuthProvider) -> Observable<ResponseLogin>
    func logout() -> Completable
}

class SessionService: SessionServiceProtocol {
    static let shared = SessionService()
    private init() {}

    func login(provider: AuthProvider) -> Observable<ResponseLogin> {
        return Observable<ResponseLogin>.create { observer in
            let parameters = PodoAPIType.makeLoginParams(provider: provider)
            let request = PodoApiManager().api.request(Router.Login.create(param: provider.rawValue(),
                                                                           parameters: parameters))
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard let responseLogin = JSON(value).to(type: ResponseLogin.self) as? ResponseLogin else {
                            observer.onError(NSError())
                            return
                        }
                        observer.onNext(responseLogin)
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
            let request = PodoApiManager().api.request(Router.Logout.create())
                .validate()
                .responseData { response in
                    KeychainService.shared.deleteSession()
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

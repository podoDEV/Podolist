//
//  PodoService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

protocol PodoServiceProtocol: ApiServiceProtocol {

    func getAllPodolist() -> Observable<[ResponsePodo]>
    func getPodo(podoId: Int) -> Observable<ResponsePodo>
}

class PodoService: PodoServiceProtocol {
    static let shared = PodoService()
    private init() { }

    func getAllPodolist() -> Observable<[ResponsePodo]> {
        return Observable<[ResponsePodo]>.create { observer in
            let request = ApiSessionService.shared.api().request(Router.Podolist.get(params: ""))
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        var responsePodolist = [ResponsePodo]()
                        for jsonPodo in JSON(value).arrayValue {
                            let content = jsonPodo.to(type: ResponsePodo.self) as! ResponsePodo
                            responsePodolist.append(content)
                        }
                        observer.onNext(responsePodolist)
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

    func getPodo(podoId: Int) -> Observable<ResponsePodo> {
        return Observable<ResponsePodo>.create { observer in
            let request = Alamofire.request(Router.Podolist.get(params: String(podoId)))
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let responsePodo = JSON(value).to(type: ResponsePodo.self) as! ResponsePodo
                        observer.onNext(responsePodo)
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

    func postPodo(requestPodo: RequestPodo) -> Completable {
        return Completable.create { completable in
            let request = ApiSessionService.shared.api().request(Router.Podolist.create(parameters: requestPodo.dict))
                .validate(statusCode: 200..<300)
                .responseData { response in
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

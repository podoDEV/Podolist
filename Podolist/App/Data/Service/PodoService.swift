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

    func getPodolist(page: Int, params: PodoParams) -> Observable<[ResponsePodo]>
    func getPodo(podoId: Int) -> Observable<ResponsePodo>
    func postPodo(requestPodo: RequestPodo) -> Observable<ResponsePodo>
    func putPodo(id: Int, requestPodo: RequestPodo) -> Observable<ResponsePodo>
    func deletePodo(id: Int) -> Completable
}

class PodoService: PodoServiceProtocol {
    static let shared = PodoService()
//    var api: PodoApi
    var sessionService: ApiSessionService
    private init() {
//        api = PodoApi.shared
        sessionService = ApiSessionService.shared
    }

    func getPodolist(page: Int, params: PodoParams) -> Observable<[ResponsePodo]> {
        return Observable<[ResponsePodo]>.create { observer in
            let parameters = PodoAPIType.makePodoParams(page: page, params: params)
//            let request = self.sessionService.api().request(Router.Podolist.get(parameters: parameters))
            let request = Alamofire.request(Router.Podolist.get(parameters: parameters))
                .validate()
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
            let request = self.sessionService.api().request(Router.Podolist.get(param: String(podoId)))
                .validate()
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

    func postPodo(requestPodo: RequestPodo) -> Observable<ResponsePodo> {
        return Observable<ResponsePodo>.create { observer in
            let request = self.sessionService.api().request(Router.Podolist.create(parameters: requestPodo.asDicsionary))
                .validate()
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
            return Disposables.create {}
        }
    }

    func putPodo(id: Int, requestPodo: RequestPodo) -> Observable<ResponsePodo> {
        return Observable<ResponsePodo>.create { observer in
            let request = self.sessionService.api().request(Router.Podolist.update(params: String(id), parameters: requestPodo.asDicsionary))
                .validate()
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
            return Disposables.create {}
        }
    }

    func deletePodo(id: Int) -> Completable {
        return Completable.create { completable in
            let request = self.sessionService.api().request(Router.Podolist.delete(params: String(id)))
                .validate()
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

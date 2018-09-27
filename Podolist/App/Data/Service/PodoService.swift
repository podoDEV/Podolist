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
    static let sharedInstance = PodoService()
    private init() { }

    func getAllPodolist() -> Observable<[ResponsePodo]> {
        return Observable<[ResponsePodo]>.create { observer in
            let request = ApiSessionService.shared.api().request(Router.Podolist.get(params: ""))
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let statusCode = response.response?.statusCode, statusCode == 200 {
                            var responsePodolist = [ResponsePodo]()
                            for jsonPodo in JSON(value).arrayValue {
                                let content = jsonPodo.to(type: ResponsePodo.self) as! ResponsePodo
                                responsePodolist.append(content)
                            }
                            observer.onNext(responsePodolist)
                            observer.onCompleted()
                        } else {
                            observer.onError("" as! Error)
                        }
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
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let statusCode = response.response?.statusCode, statusCode == 200 {
                            let responsePodo = JSON(value).to(type: ResponsePodo.self) as! ResponsePodo
                            observer.onNext(responsePodo)
                            observer.onCompleted()
                        } else {
                            observer.onError("" as! Error)
                        }
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
}

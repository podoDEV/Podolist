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

    func getAllPodolist() -> Observable<JsonPayload<JsonResults<Podo>>>
}

class PodoService: PodoServiceProtocol {
    static let sharedInstance = PodoService()

    private init() { }

    typealias ResponseData = Observable<JSON>

    let mock = JSON(["header": ["isSuccessful": true, "errorCode": 0, "errorMessage": ""],
                     "result": ["count": "2", "contents": [["id": "123", "title": "Kim"],
                                                           ["id": "122", "title": "Heebeom"]]]])

    func getAllPodolist() -> Observable<JsonPayload<JsonResults<Podo>>> {

        return Observable.create { observer -> Disposable in

            //            let request = Alamofire.request(Router.Wishes.get(params: "")).validate().responseJSON { responseData in
            //
            //                switch(responseData.result) {
            //                case .success(let value):
            //                    if let statusCode = responseData.response?.statusCode, statusCode == 200 {
            //                        let responseJson = JSON(value)
            //                        observer.onCompleted()
            //                    } else {
            //                        observer.onError(NSError(domain: "WishList", code: -1, userInfo: nil))
            //                    }
            //
            //                case .failure(let error): break
            //                    observer.onError(NSError(domain: "WishList", code: -1, userInfo: nil))
            //                }
            let jsonPayload: JsonPayload<JsonResults<Podo>> = self.mock.to(type: JsonPayload<JsonResults<Podo>>.self) as! JsonPayload<JsonResults<Podo>>
            observer.onNext(jsonPayload)

            return Disposables.create {
                //                request.cancel()
            }
        }
    }

    func getPodo() {
//        let getUserStatus = Router.Podolist("initFabian").getStatus(params: "2")
//        let createUserStatus = Router.Podolist("initFabian").createStatus(parameters: ["title": "fabians post"])
//        let deleteUserStatus = Router.Podolist("initFabian").deleteStatus(params: "2")

        let crazyNested = Router.Podolist("12")
            .status(params: "123")
            .picture(params: "1234")

        print(crazyNested)
        /// users/12/status/123/pictures/1234
    }
}

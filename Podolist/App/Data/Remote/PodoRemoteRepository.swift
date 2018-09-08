//
//  PodoRemoteRepository.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

class PodoRemoteRepository: PodoRemoteDataSource {

    func getPodolist() -> Observable<[Podo]>? {
        return PodoService.sharedInstance.getAllPodolist()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap({ jsonData -> Observable<[Podo]> in
                let jsonResults: JsonResults<Podo> = jsonData.result as! JsonResults<Podo>
                let podolist: [Podo] = jsonResults.contents as! [Podo]
                return Observable.just(podolist)
            })
    }

    func postPodo(_ podo: Podo) {

    }

    func putPodo() {

    }

    func deletePodo() {

    }
}

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
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap({ responsePodolist -> Observable<[Podo]> in
                let podolist: [Podo] = responsePodolist.map { Podo(responsePodo: $0) }
                return Observable.just(podolist)
            })
    }

    func getPodo(podoId: Int) -> Observable<Podo>? {
        return PodoService.sharedInstance.getPodo(podoId: podoId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap({ responsePodo -> Observable<Podo> in
                return Observable.just(Podo(responsePodo: responsePodo))
            })
    }

    func postPodo(_ podo: Podo) {

    }

    func putPodo() {

    }

    func deletePodo() {

    }
}

//
//  PodoAPI.swift
//  Podolist
//
//  Created by NHNEnt on 02/11/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import Alamofire
import Foundation

typealias FilterParam = (filterType: FilterType, value: Bool)
//typealias SortParam = SortType
typealias DateParam = (dateType: DateType, value: Date)
typealias PodoParams = (filterParam: FilterParam, dateParam: DateParam)

enum FilterType: String {
    case complete
    case delay
}

enum SortType: String {
    case create
    case update
    case due
}

enum DateType {
    case dueAt
    case completedAt
}

enum OrderType: String {
    case ascending = "ASC"
    case descending = "DESC"
}

final class PodoAPIType {

    static func makePodoParams(page: Int, params: PodoParams) -> Parameters {
        var parameters = Parameters()
        parameters["page"] = page
        parameters["size"] = 100

        let filterParam = params.filterParam
        switch filterParam.filterType {
        case .complete:
            parameters["isCompleted"] = String(filterParam.value)
        case .delay:
            parameters["isDelayed"] = String(filterParam.value)
        }

        let dateParam = params.dateParam
        switch dateParam.dateType {
        case .completedAt:
            parameters["completedAtFrom"] = Int(Date().timeIntervalSince1970) //dateParam.value.
            parameters["completedAtTo"] = Int(Date().timeIntervalSince1970) //dateParam.value
        case .dueAt:
            parameters["dueAtFrom"] = Int(Date().timeIntervalSince1970) //dateParam.value
            parameters["dueAtTo"] = Int(Date().timeIntervalSince1970) //dateParam.value
        }

        return parameters
    }
//    static let shared = PodoApi()
//    var service: SessionManager?
//    private init() {}

//    func api() -> SessionManager {
//
//        service = SessionManager()
//        guard KeychainService.shared.hasValue(key: "session") else {
//            return service!
//        }
//
//        KeychainService.shared.findValue(
//            onSuccess: { session in
//                if let session = session {
//                    self.service!.adapter = SessionAdapter(session: session)
//                }
//        }, onError: { error in
//
//        })
//        return service!
//    }
//
//    func request() {
//        self.api().request(Router.Podolist.get(parameters: [:]))
//    }
//}
}

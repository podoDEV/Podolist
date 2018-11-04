//
//  PodoAPI.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Alamofire

typealias FilterParam = (filterType: FilterType, value: Bool)
//typealias SortParam = SortType
typealias DateParam = (dateType: DateType, value: Date)
typealias PodoParams = (filterParams: [FilterParam], dateParam: DateParam)

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
//        parameters["page"] = page
//        parameters["size"] = 100

        let filterParams = params.filterParams
        for filter in filterParams {
            switch filter.filterType {
            case .complete:
                parameters["isCompleted"] = filter.value
            case .delay:
                parameters["isDelayed"] = filter.value
            }
        }

        let dateParam = params.dateParam
        switch dateParam.dateType {
        case .completedAt:
            parameters["completedAtFrom"] = dateParam.value.dateAt(.startOfDay).date.timeIntervalSince1970
            parameters["completedAtTo"] = dateParam.value.dateAt(.endOfDay).date.timeIntervalSince1970
        case .dueAt:
            parameters["dueAtFrom"] = dateParam.value.dateAt(.startOfDay).date.timeIntervalSince1970
            parameters["dueAtTo"] = dateParam.value.dateAt(.endOfDay).date.timeIntervalSince1970
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

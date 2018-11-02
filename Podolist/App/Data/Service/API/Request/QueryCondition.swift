////
////  QueryCondition.swift
////  Podolist
////
////  Created by NHNEnt on 31/10/2018.
////  Copyright © 2018 podo. All rights reserved.
////
//
//import Alamofire
//
//class Query {
//
//    private var parameters: Parameters = [:]
//}
//
//extension Query {
//
//    @discardableResult
//    func q(key: QParam, value: Any) -> Self {
//        parameters["\(key.rawValue)"] = value
//        return self
//    }
//
//    @discardableResult
//    func order(key: OrderParam, value: OrderType) -> Self {
//        parameters["\(key.rawValue)"] = value.rawValue
//        return self
//    }
//
//    @discardableResult
//    func limit(_ limit: Int?) -> Self {
//        if let limit = limit {
//            parameters["size"] = limit
//        }
//        return self
//    }
//
//    func build() -> Parameters {
//        return parameters
//    }
//
////    @discardableResult
////    func order(sortType: FileListSortType?) -> Self {
////        guard let sortType = sortType else { return self }
////        switch sortType {
////        case .modifyDateLatest:
////            order(key: .objectModifyDateTime, value: .descending)
////        case .modifyDateOldest:
////            order(key: .objectModifyDateTime, value: .ascending)
////        case .nameAscending:
////            order(key: .objectName, value: .ascending)
////        case .nameDescending:
////            order(key: .objectName, value: .descending)
////        case .sizeAscending:
////            order(key: .objectSize, value: .ascending)
////        case .sizeDescending:
////            order(key: .objectSize, value: .descending)
////        case .shootDescending:
////            order(key: .objectCreateDateTime, value: .descending)
////        case .shootAscending:
////            order(key: .objectCreateDateTime, value: .ascending)
////        case .uploadDescending:
////            order(key: .uploadDateTime, value: .descending)
////        case .uploadAscending:
////            order(key: .uploadDateTime, value: .ascending)
////        }
////        return self
////    }
//}

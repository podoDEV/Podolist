////
////  DefaultRequest.swift
////  Podolist
////
////  Created by NHNEnt on 31/10/2018.
////  Copyright © 2018 podo. All rights reserved.
////
//
//import Alamofire
//
//public protocol RequestType {
//
//    var path: String { get }
//    var method: HTTPMethod { get }
//    var httpHeaders: HTTPHeaders? { get }
//    var queryItems: [URLQueryItem]? { get }
////    var payload: HTTPBody? { get }
//
//}
//
//enum DefaultRequest {
//    case get2()
//    case get(url: String, headers: HTTPHeaders?, queryItems: [URLQueryItem]?)
//    case post(url: String, headers: HTTPHeaders?, queryItems: [URLQueryItem]?, payload: Data?)
//    case put(url: String, headers: HTTPHeaders?, queryItems: [URLQueryItem]?, payload: Data?)
//    case delete(url: String, headers: HTTPHeaders?, queryItems: [URLQueryItem]?)
//}
//
//extension DefaultRequest: RequestType {
//
//    public var path: String {
//        switch self {
//        case .get(let url, _, _):
//            return url
//        case .post(let url, _, _, _):
//            return url
//        case .put(let url, _, _, _):
//            return url
//        case .delete(let url, _, _):
//            return url
//        }
//    }
//
//    public var method: HTTPMethod {
//        switch self {
//        case .get: return .get
//        case .post: return .post
//        case .put: return .put
//        case .delete: return .delete
//        }
//    }
//
//    public var httpHeaders: HTTPHeaders? {
//        switch self {
//        case .get(_, let headers, _):
//            return headers
//        case .post(_, let headers, _, _):
//            return headers
//        case .put(_, let headers, _, _):
//            return headers
//        case .delete(_, let headers, _):
//            return headers
//        }
//    }
//
//    public var queryItems: [URLQueryItem]? {
//        switch self {
//        case .get(_, _, let queryItems):
//            return queryItems
//        case .post(_, _, let queryItems, _):
//            return queryItems
//        case .put(_, _, let queryItems, _):
//            return queryItems
//        case .delete(_, _, let queryItems):
//            return queryItems
//        }
//    }
//
//    public var payload: HTTPBody? {
//        switch self {
//        case .get, .delete:
//            return nil
//        case .post(_, _, _, let payload):
//            return payload
//        case .put(_, _, _, let payload):
//            return payload
//        }
//    }
//
//}

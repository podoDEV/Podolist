//
//  ApiServiceProtocol.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

protocol ApiServiceProtocol {
    //    associatedtype ResponseData
}

class ApiService: ApiServiceProtocol {
    static let sharedInstance = ApiService()

    private init() { }

//    typealias ResponseData = JsonPayload
}

//
//  AccessTokenAdapter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire

class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Router.basePath) {
            urlRequest.setValue(accessToken, forHTTPHeaderField: "Cookie")
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }
}

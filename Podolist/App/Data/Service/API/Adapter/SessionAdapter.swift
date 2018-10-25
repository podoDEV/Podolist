//
//  SessionAdapter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire

class SessionAdapter: RequestAdapter {
    private let session: String

    init(session: String) {
        self.session = session
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Router.basePath) {
            urlRequest.setValue(session, forHTTPHeaderField: "Cookie")
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }
}

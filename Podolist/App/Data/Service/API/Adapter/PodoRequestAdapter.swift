//
//  PodoRequestAdapter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire

class PodoRequestAdapter: RequestAdapter {
    private var session: Session?

    init() {}

    init(session: Session?) {
        self.session = session
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Router.basePath),
            let session = self.session {
            urlRequest.setValue("SESSIONID=" + session + ";", forHTTPHeaderField: "Cookie")
        }

        return urlRequest
    }
}

//
//  Networking.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Moya

typealias AuthNetworking = Networking<AuthAPI>
typealias TodoNetworking = Networking<TodoAPI>

final class Networking<Target: TargetType>: MoyaProvider<Target> {

    init(plugins: [PluginType] = []) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 5

        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        super.init(manager: manager, plugins: plugins)
    }

    func request<T: Codable>(
        _ target: Target,
        completion: @escaping (Result<T, PodoError>) -> Void
    ) {
        let requestString = "\(target.method) \(target.path)"
        let message = "REQUEST: \(requestString)"
        log.debug(message)
        self.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(T.self)
                    let message = "SUCCESS: \(requestString) (\(response.statusCode))"
                    log.debug(message)
                    completion(.success(data))
                } catch {
                    let message = "FAILURE: \(requestString) (\(response.statusCode))"
                    log.warning(message)
                    completion(.failure(.parsingError))
                }
            case .failure(let error):
                if let response = error.response {
                  if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                    let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                    log.warning(message)
                    completion(.failure(.parsingError))
                  } else if let rawString = String(data: response.data, encoding: .utf8) {
                    let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                    log.warning(message)
                    completion(.failure(.unknown))
                  } else {
                    let message = "FAILURE: \(requestString) (\(response.statusCode))"
                    log.warning(message)
                    completion(.failure(.unknown))
                  }
                } else {
                    let message = "FAILURE: \(requestString)\n\(error)"
                    log.warning(message)
                    completion(.failure(.unknown))
                }
            }
        }
    }
}

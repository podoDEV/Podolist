//
//  Networking.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Alamofire
import Moya

public typealias AuthNetworking = Networking<AuthAPI>
public typealias TodoNetworking = Networking<TodoAPI>

public final class Networking<Target: TargetType>: MoyaProvider<Target> {

  public init(plugins: [PluginType] = []) {
    super.init(plugins: plugins)
  }

  private func request(
    target: Target,
    completion: @escaping (Result<Response, PodoError>) -> Void
  ) {
    let requestString = "\(target.method) \(target.path)"
    let message = "REQUEST: \(requestString)"
    log.debug(message)
    self.request(target) { result in
      switch result {
      case .success(let response):
        let message = "SUCCESS: \(requestString) (\(response.statusCode))"
        log.debug(message)
        completion(.success(response))
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

  func request<T: Codable>(
    type: Target,
    completion: @escaping (Result<T, PodoError>) -> Void
  ) {
    self.request(target: type) { result in
      switch result {
      case .success(let response):
        do {
          let data = try response.map(T.self)
          completion(.success(data))
        } catch {
          completion(.failure(.parsingError))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func request(
    type: Target,
    completion: @escaping (Result<Void, PodoError>) -> Void
  ) {
    self.request(target: type) { result in
      switch result {
      case .success:
        completion(.success(()))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

//
//  TodoAPI.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation
import Moya

public enum TodoAPI {
    case getTodos(page: Int, date: Date)
    case postTodo(todo: Todo)
    case putTodo(id: Int, todo: Todo)
    case deleteTodo(id: Int)
}

extension TodoAPI: TargetType {
    public var baseURL: URL {
        return URL(string: AppUtils.baseURL)!
    }

    public var path: String {
        switch self {
        case .getTodos: return "items"
        case .postTodo: return "items"
        case .putTodo(let id, _): return "items/\(id)"
        case .deleteTodo(let id): return "items/\(id)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .postTodo:
            return .post
        case .putTodo:
            return .put
        case .deleteTodo:
            return .delete
        default:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .getTodos(let page, let date):
            let dateParam = date.stringYYYYMMDD()
            return .requestParameters(
                parameters: ["date": dateParam, "page": page],
                encoding: URLEncoding.default
            )
        case .postTodo(let todo):
            return .requestParameters(
                parameters: todo.asParameters,
                encoding: JSONEncoding.default
            )
        case .putTodo(_, let todo):
            return .requestParameters(
                parameters: todo.asParameters,
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    public var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}

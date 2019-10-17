//
//  TodoAPI.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation
import Moya

enum TodoAPI {
    case getTodos(page: Int, date: Date)
    case newTodo(podo: Podo)
    case editTodo(id: Int, podo: Podo)
    case deleteTodo(id: Int)
}

extension TodoAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://myshort.info/api")!
    }

    var path: String {
        switch self {
        case .getTodos: return "items"
        case .newTodo: return "items"
        case .editTodo(let id, _): return "items/\(id)"
        case .deleteTodo(let id): return "items/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .newTodo:
            return .post
        case .editTodo:
            return .put
        case .deleteTodo:
            return .delete
        default:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getTodos(let page, let date):
            let dateParam = date.stringYYYYMMDD()
            return .requestCompositeParameters(
                bodyParameters: [:],
                bodyEncoding: JSONEncoding.default,
                urlParameters: ["date": dateParam,
                                "page": page]
            )
        case .newTodo(let podo):
            return .requestParameters()
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}

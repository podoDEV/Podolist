//
//  TodoService.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

protocol TodoServiceType {
    func getTodos(page: Int, date: Date, _ completion: @escaping (Result<[Podo], PodoError>) -> Void)
}

final class TodoService: TodoServiceType {
    private let networking: TodoNetworking

    init(networking: TodoNetworking) {
        self.networking = networking
    }

    func getTodos(page: Int, date: Date, _ completion: @escaping (Result<[Podo], PodoError>) -> Void) {
        networking.request(.getTodos(page: page, date: date), completion: completion)
    }
}

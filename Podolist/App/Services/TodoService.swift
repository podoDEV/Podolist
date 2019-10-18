//
//  TodoService.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

protocol TodoServiceType {
    func getTodos(page: Int, date: Date, _ completion: @escaping (Result<Podolist, PodoError>) -> Void)
//    func getTodo(id: Int, _ completion: @escaping (Result<Podo, PodoError>) -> Void)
    func newTodo(podo: Podo, _ completion: @escaping (Result<Podo, PodoError>) -> Void)
    func updateTodo(id: Int, podo: Podo, _ completion: @escaping (Result<Podo, PodoError>) -> Void)
    func deleteTodo(id: Int, _ completion: @escaping (Result<(), PodoError>) -> Void)
}

final class TodoService: TodoServiceType {
    private let networking: TodoNetworking

    init(networking: TodoNetworking) {
        self.networking = networking
    }

    func getTodos(page: Int, date: Date, _ completion: @escaping (Result<Podolist, PodoError>) -> Void) {
        networking.request(.getTodos(page: page, date: date), completion: completion)
    }

    func newTodo(podo: Podo, _ completion: @escaping (Result<Podo, PodoError>) -> Void) {
        networking.request(.postTodo(podo: podo), completion: completion)
    }

    func updateTodo(id: Int, podo: Podo, _ completion: @escaping (Result<Podo, PodoError>) -> Void) {
        networking.request(.updateTodo(id: id, podo: podo), completion: completion)
    }

    func deleteTodo(id: Int, _ completion: @escaping (Result<(), PodoError>) -> Void) {
        networking.requestWithLog(.deleteTodo(id: id)) { result in
            switch result {
            case .success(let response):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.unknown))
            }
        }
    }
}

//
//  TodoService.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

protocol TodoServiceType {
    func getTodos(page: Int, date: Date, _ completion: @escaping (Result<Todolist, PodoError>) -> Void)
//    func getTodo(id: Int, _ completion: @escaping (Result<Podo, PodoError>) -> Void)
    func newTodo(todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void)
    func updateTodo(id: Int, todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void)
    func deleteTodo(id: Int, _ completion: @escaping (Result<(), PodoError>) -> Void)
}

final class TodoService: TodoServiceType {
    private let networking: TodoNetworking

    init(networking: TodoNetworking) {
        self.networking = networking
    }

    func getTodos(page: Int, date: Date, _ completion: @escaping (Result<Todolist, PodoError>) -> Void) {
        networking.request(.getTodos(page: page, date: date), completion: completion)
    }

    func newTodo(todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void) {
        networking.request(.postTodo(todo: todo), completion: completion)
    }

    func updateTodo(id: Int, todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void) {
        networking.request(.updateTodo(id: id, todo: todo), completion: completion)
    }

    func deleteTodo(id: Int, _ completion: @escaping (Result<(), PodoError>) -> Void) {
        networking.requestWithLog(.deleteTodo(id: id)) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

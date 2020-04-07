//
//  TodoService.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

public protocol TodoServiceType {
    func getTodos(page: Int, date: Date, _ completion: @escaping (Result<Todolist, PodoError>) -> Void)
    func newTodo(todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void)
    func updateTodo(id: Int, todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void)
    func deleteTodo(id: Int, _ completion: @escaping (Result<(), PodoError>) -> Void)
}

public final class TodoService: TodoServiceType {
    private let networking: TodoNetworking

    public init(networking: TodoNetworking) {
        self.networking = networking
    }

    public func getTodos(page: Int, date: Date, _ completion: @escaping (Result<Todolist, PodoError>) -> Void) {
        networking.request(type: .getTodos(page: page, date: date), completion: completion)
    }

    public func newTodo(todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void) {
        networking.request(type: .postTodo(todo: todo), completion: completion)
    }

    public func updateTodo(id: Int, todo: Todo, _ completion: @escaping (Result<Todo, PodoError>) -> Void) {
        networking.request(type: .putTodo(id: id, todo: todo), completion: completion)
    }

    public func deleteTodo(id: Int, _ completion: @escaping (Result<(), PodoError>) -> Void) {
        networking.request(type: .deleteTodo(id: id), completion: completion)
    }
}

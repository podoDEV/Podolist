//
//  TodolistInteractor.swift
//  Podolist
//
//  Created by hb1love on 2019/10/20.
//  Copyright © 2019 podo. All rights reserved.
//

protocol TodolistInteractorProtocol: AnyObject {
    // MARK: - Presenter -> Interactor
    func fetchTodolist(_ date: Date)
    func createTodo(todo: Todo)
    func updateTodo(id: Int, todo: Todo)
    func updateComplete(id: Int, complete: Todo)
    func updateShowDelayedItems(show: Bool)
}

class TodolistInteractor: TodolistInteractorProtocol {
    weak var presenter: TodolistPresenterProtocol?
    private var todoService: TodoServiceType

    // MARK: - Properties

    private var currentPage: Int = 0
    private var showDelayedItems = true

    init(todoService: TodoServiceType) {
        self.todoService = todoService
    }
}

// MARK: - Presenter -> Interactor
extension TodolistInteractor {
    func fetchTodolist(_ date: Date) {
        todoService.getTodos(page: 0, date: date) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let todolist):
                var sections: [TodoSection] = []
                if let delayed = todolist.delayedItems {
                    sections.append(TodoSection(
                        title: "list.delayedItems".localized,
                        color: .delayedItems,
                        rows: delayed,
                        visible: self.showDelayedItems
                    ))
                }
                if let items = todolist.items {
                    sections.append(TodoSection(
                        title: "list.items".localized,
                        color: .normalItems,
                        rows: items
                    ))
                }
                self.presenter?.setTodolist(sections: sections)
            case .failure(let error):
                log.d(error)
            }
        }
    }

    func createTodo(todo: Todo) {
        todoService.newTodo(todo: todo) { [weak self] result in
            switch result {
            case .success(let todo):
                break
            case .failure(let error):
                log.d(error)
            }
        }
    }

    func updateTodo(id: Int, todo: Todo) {
        todoService.updateTodo(id: id, todo: todo) { [weak self] result in
            switch result {
            case .success(let todo):
                break
            case .failure(let error):
                log.d(error)
            }
        }
    }

    func updateComplete(id: Int, complete: Todo) {

    }

    func updateShowDelayedItems(show: Bool) {
        self.showDelayedItems = show
    }
}

////
////  TodolistInteractor.swift
////  Podolist
////
////  Created by hb1love on 2019/10/20.
////  Copyright © 2019 podo. All rights reserved.
////
//
//import Core
//
//protocol TodolistInteractorProtocol: AnyObject {
//
//    // MARK: - Presenter -> Interactor
//
//    func fetchTodolist(_ date: Date, reload: Bool)
//    func createTodo(todo: Todo)
//    func updateTodo(id: Int, todo: Todo)
//    func deleteTodo(id: Int)
//
//    func updateShowDelayedItems(show: Bool)
//}
//
//class TodolistInteractor: TodolistInteractorProtocol {
//    weak var presenter: TodolistPresenterProtocol?
//    private var todoService: TodoServiceType
//
//    // MARK: - Properties
//
//    private var currentPage: Int = 0
//    private var showDelayedItems = true
//    private var todolist: Todolist?
//
//    init(todoService: TodoServiceType) {
//        self.todoService = todoService
//    }
//}
//
//// MARK: - Presenter -> Interactor
//
//extension TodolistInteractor {
//    func fetchTodolist(_ date: Date, reload: Bool = true) {
//        if reload == false, let todolist = self.todolist {
//            let sections = updateSections(date: date, todolist: todolist)
//            self.presenter?.setTodolist(sections: sections)
//            return
//        }
//        todoService.getTodos(page: 0, date: date) { [weak self] result in
//            guard let `self` = self else { return }
//            switch result {
//            case .success(let todolist):
//                self.todolist = todolist
//                let sections = self.updateSections(date: date, todolist: todolist)
//                self.presenter?.setTodolist(sections: sections)
//            case .failure(let error):
//                log.debug(error)
//            }
//        }
//    }
//
//    func createTodo(todo: Todo) {
//        todoService.newTodo(todo: todo) { [weak self] result in
//            switch result {
//            case .success(let todo):
//                self?.presenter?.createTodoDidFinished(todo: todo)
//            case .failure(let error):
//                log.debug(error)
//            }
//        }
//    }
//
//    func updateTodo(id: Int, todo: Todo) {
//        todoService.updateTodo(id: id, todo: todo) { [weak self] result in
//            switch result {
//            case .success(let todo):
//                self?.presenter?.updateTodoDidFinished(id: id, todo: todo)
//            case .failure(let error):
//                log.debug(error)
//            }
//        }
//    }
//
//    func deleteTodo(id: Int) {
//        todoService.deleteTodo(id: id) { [weak self] result in
//            switch result {
//            case .success:
//                self?.presenter?.deleteTodoDidFinished()
//            case .failure(let error):
//                log.debug(error)
//            }
//        }
//    }
//
//    func updateShowDelayedItems(show: Bool) {
//        self.showDelayedItems = show
//    }
//}
//
//private extension TodolistInteractor {
//    func updateSections(date: Date, todolist: Todolist) -> [TodoSection] {
//        var sections: [TodoSection] = []
//        if let delayed = todolist.delayedItems, !delayed.isEmpty {
//            sections.append(
//                TodoSection(
//                    title: "list.delayedItems".localized,
//                    color: .delayedItems,
//                    rows: delayed,
//                    editable: false,
//                    visible: showDelayedItems
//                )
//            )
//        }
//        let items = todolist.items ?? []
//        let isToday = CalendarUtils.isToday(date: date)
//        let title = isToday ? "list.items".localized : date.displayYYYYMMDD()
//        sections.append(
//            TodoSection(
//                title: title,
//                color: .normalItems,
//                rows: items
//            )
//        )
//        return sections
//    }
//}

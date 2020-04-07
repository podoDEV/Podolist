//
//  TodolistPresenter.swift
//  Podolist
//
//  Created by hb1love on 2019/10/20.
//  Copyright © 2019 podo. All rights reserved.
//

import Core

enum WritingMode {
    case create
    case edit
}

enum WritingViewState {
    case `default`
    case expand
    case writing
}

protocol TodolistPresenterProtocol: class {

    // MARK: - View -> Presenter

    var selectedDate: Date { get }

    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func configureSection(_ cell: TodolistSectionCell, forSectionAt section: Int)
    func configureRow(_ cell: TodolistRowCell, forRowAt indexPath: IndexPath)
    func didSelect(indexPath: IndexPath)
    func didTouchedBackground()
    func didChangedComplete(indexPath: IndexPath, completed: Bool)
    func didTappedEdit(_ todo: Todo, indexPath: IndexPath)
    func didTappedDelete(indexPath: IndexPath)
    func didChangedShowDelayed(show: Bool)
    func keyboardWillShow()

    // MARK: - Interactor -> Presenter
    
    func setTodolist(sections: [TodoSection])
    func createTodoDidFinished(todo: Todo)
    func updateTodoDidFinished(id: Int, todo: Todo)
    func deleteTodoDidFinished()
    func resetTodoOnWriting()
}

final class TodolistPresenter: NSObject, TodolistPresenterProtocol {

    // MARK: - Properties

    private var view: TodolistViewProtocol!
    private var interactor: TodolistInteractorProtocol!
    private var wireFrame: TodolistWireFrameProtocol!

    private(set) var selectedDate = Date()
    private var todo = Todo()
    private var sections: [TodoSection] = []
    private var writingMode: WritingMode = .create
    private var selectedIndexPath: IndexPath?
    private var viewState: WritingViewState = .default {
        didSet {
            switch viewState {
            case .default:
                view.showDefaultState()
            case .expand:
                view.showWritingExpandState()
            case .writing:
                view.showWritingTitleState()
            }
        }
    }

    init(
        view: TodolistViewProtocol,
        wireframe: TodolistWireFrameProtocol,
        interactor: TodolistInteractorProtocol
        ) {
        self.view = view
        self.wireFrame = wireframe
        self.interactor = interactor
    }
}

// MARK: - View -> Presenter

extension TodolistPresenter {
    func viewDidLoad() {
        interactor.fetchTodolist(selectedDate, reload: true)
        view.showTodoOnWriting(todo, mode: writingMode)
    }

    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfRows(in section: Int) -> Int {
        let section = sections[section]
        return section.visible ? section.rows.count : 0
    }

    func configureSection(_ cell: TodolistSectionCell, forSectionAt section: Int) {
        let item = sections[section]
        cell.configure(item)
        cell.presenter = self
    }

    func configureRow(_ cell: TodolistRowCell, forRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].rows[indexPath.row]
        let isSelected = indexPath.section == selectedIndexPath?.section
            && indexPath.row == selectedIndexPath?.row
        cell.configure(item, indexPath: indexPath, isSelected: isSelected)
        cell.selectionStyle = .none
        cell.presenter = self
    }

    func didSelect(indexPath: IndexPath) {
        var indexPathsToReload: [IndexPath] = []
        if let prev = self.selectedIndexPath {
            indexPathsToReload.append(prev)
            if prev == indexPath {
                self.selectedIndexPath = nil
            } else {
                self.selectedIndexPath = indexPath
                indexPathsToReload.append(indexPath)
            }
        } else {
            self.selectedIndexPath = indexPath
            indexPathsToReload.append(indexPath)
        }

        view.reloadRows(indexPathsToReload, with: .automatic)
    }

    func didTouchedBackground() {
        if writingMode == .edit {
            resetTodoOnWriting()
            view.showTodoOnWriting(todo, mode: writingMode)
        }
        viewState = .default
        view.hideMonthCalendar()
    }

    func resetTodoOnWriting() {
        writingMode = .create
        todo = Todo()
        didChangedDate(date: selectedDate)
    }

    func didChangedComplete(indexPath: IndexPath, completed: Bool) {
        let todo = sections[indexPath.section].rows[indexPath.row]
        guard let id = todo.id else { return }
        todo.isCompleted = completed
        interactor.updateTodo(id: id, todo: todo)
    }

    func didTappedEdit(_ todo: Todo, indexPath: IndexPath) {
        analytics.log(.todo_edit)
        self.todo = todo
        writingMode = .edit
        didSelect(indexPath: indexPath)
        view.showTodoOnWriting(todo, mode: writingMode)
        viewState = .expand
    }

    func didTappedDelete(indexPath: IndexPath) {
        guard let id = sections[indexPath.section].rows[indexPath.row].id else { return }
        interactor.deleteTodo(id: id)
        view.reloadRows([indexPath], with: .automatic)
    }

    func didChangedShowDelayed(show: Bool) {
        interactor.updateShowDelayedItems(show: show)
        view.reloadSections([0], with: .automatic)
    }

    func keyboardWillShow() {
        viewState = .writing
    }
}

// MARK: - Interactor -> Presenter

extension TodolistPresenter {
    func setTodolist(sections: [TodoSection]) {
        self.sections = sections
        view.reloadData()
    }

    func createTodoDidFinished(todo: Todo) {
        analytics.log(.todo_create(todo.title ?? ""))
        selectedDate = todo.startedAt ?? selectedDate
        resetTodoOnWriting()
        viewState = .default
        view.showTodoOnWriting(self.todo, mode: writingMode)
        view.showTopView(selectedDate)
        selectedIndexPath = nil
        interactor.fetchTodolist(selectedDate, reload: true)
    }

    func updateTodoDidFinished(id: Int, todo: Todo) {
        analytics.log(.todo_edit_done)
        resetTodoOnWriting()
        viewState = .default
        view.showTodoOnWriting(self.todo, mode: writingMode)
        selectedIndexPath = nil
        interactor.fetchTodolist(selectedDate, reload: true)
    }

    func deleteTodoDidFinished() {
        analytics.log(.todo_delete)
        selectedIndexPath = nil
        interactor.fetchTodolist(selectedDate, reload: true)
    }
}

// MARK: - MonthCalendarViewDelegate

extension TodolistPresenter: MonthCalendarViewDelegate {

    func calendarView(_ calendarView: MonthCalendarView, didSelectDate date: Date) {
        selectedDate = date
        view.showTopView(date)
        didChangedDate(date: date)
        view.showTodoOnWriting(todo, mode: writingMode)
        interactor.fetchTodolist(selectedDate, reload: true)
    }
}

// MARK: - MainTopViewDelegate

extension TodolistPresenter: MainTopViewDelegate {

    func didTappedSetting() {
        wireFrame.navigate(to: .setting)
    }

    func didTappedMonthCalendar() {
        view.showMonthCalendar(selectedDate)
    }

    func didSelectDate(date: Date) {
        selectedDate = date
        didChangedDate(date: date)
        view.showTodoOnWriting(todo, mode: writingMode)
        interactor.fetchTodolist(selectedDate, reload: true)
    }
}

// MARK: - WriteViewDelegate

extension TodolistPresenter: WriteViewDelegate {

    func textFieldDidChange(text: String) {
        todo.title = text
    }

    func didChangedPriority(priority: Priority) {
        todo.priority = priority
    }

    func didChangedDate(date: Date) {
        todo.startedAt = date
        todo.endedAt = date
        todo.dueAt = date
    }

    func didTappedDetail() {
        if viewState == .default || viewState == .writing {
            viewState = .expand
        } else {
            viewState = .default
        }
    }

    func didTappedCreate() {
        interactor.createTodo(todo: todo)
    }

    func didTappedEdit() {
        guard let id = todo.id else { return }
        interactor.updateTodo(id: id, todo: todo)
    }
}

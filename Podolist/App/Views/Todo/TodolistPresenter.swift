//
//  TodolistPresenter.swift
//  Podolist
//
//  Created by hb1love on 2019/10/20.
//  Copyright © 2019 podo. All rights reserved.
//

//import SwiftDate

protocol TodolistPresenterProtocol: class {
    // MARK: - View -> Presenter
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

    // MARK: - Interactor -> Presenter
    func setTodolist(sections: [TodoSection])
    func updateTodo(id: Int, todo: Todo)
}

final class TodolistPresenter: NSObject, TodolistPresenterProtocol {

    // MARK: - Properties

    private var view: TodolistViewProtocol!
    private var interactor: TodolistInteractorProtocol!
    private var wireFrame: TodolistWireFrameProtocol!

    private var selectedDate = Date()
    private var todo = Todo()
    private var sections: [TodoSection] = []
    private var writingMode: WritingMode = .create

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
        interactor.fetchTodolist(selectedDate)
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
        cell.configure(item, indexPath: indexPath, isSelected: false)
        cell.selectionStyle = .none
        cell.presenter = self
    }

    func didSelect(indexPath: IndexPath) {

    }

    func didTouchedBackground() {
        if writingMode == .edit {
            resetTodoOnWriting()
            view.showTodoOnWriting(todo, mode: writingMode)
        }
        view.showDefaultState()
        view.hideMonthCalendar()
    }

    func resetTodoOnWriting() {
        self.writingMode = .create
        self.todo = Todo()
    }

    func didChangedComplete(indexPath: IndexPath, completed: Bool) {
//        interactor.updateComplete(id: <#T##Int#>, complete: <#T##Todo#>)
//        interactor.updateComplete(indexPath: indexPath, completed: completed)!
//            .flatMap { _ in
//                self.interactor.fetchPodolist()!
//            }
//            .observeOn(MainScheduler.instance)
//            .subscribe(
//                onNext: { podoSections in
//                    self.view.showPodolist()
//            }, onError: { error in
//                print(error)
//            })
//            .disposed(by: disposeBag)
    }

    func didTappedEdit(_ todo: Todo, indexPath: IndexPath) {
//        gaEvent(GADefine.Podo, action: GADefine.edit)
//        interactor.updatePodoOnWriting(podo)
//        view.showPodoOnWriting(podo, mode: interactor.writingMode)
        view.showWritingExpandState()
    }

    func didTappedDelete(indexPath: IndexPath) {
//        gaEvent(GADefine.Podo, action: GADefine.delete)
//        interactor.deletePodo(indexPath: indexPath)!
//            .observeOn(MainScheduler.instance)
//            .subscribe(onCompleted: { [weak self] in
//                self?.view.deleteRows([indexPath], with: .fade)
//                self?.view.reloadSections([0], with: .automatic)
//            }, onError: { error in
//                print(error)
//            })
//            .disposed(by: disposeBag)
    }

    func didChangedShowDelayed(show: Bool) {
        interactor.updateShowDelayedItems(show: show)
        view.reloadSections([0], with: .automatic)
    }

}

// MARK: - Interactor -> Presenter
extension TodolistPresenter {
    func setTodolist(sections: [TodoSection]) {
        self.sections = sections
        view.reloadData()
    }

    func updateTodo(id: Int, todo: Todo) {}
}

// MARK: - MonthCalendarViewDelegate

extension TodolistPresenter: MonthCalendarViewDelegate {

    func calendarView(_ calendarView: MonthCalendarView, didSelectDate date: Date) {
        selectedDate = date
        view.showTopView(date)
        interactor.fetchTodolist(selectedDate)
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
        interactor.fetchTodolist(selectedDate)
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
        view.showWritingExpandState()
    }

    func didTappedCreate() {
        interactor.createTodo(todo: todo)
//        interactor.createPodo()!
//            .do {
//                gaEvent(GADefine.Podo, action: GADefine.create)
//            }
//            .flatMap { _ in
//                self.interactor.fetchPodolist()!
//            }
//            .observeOn(MainScheduler.instance)
//            .subscribe(
//                onNext: { _ in
//                    self.view.showPodolist()
//                    self.interactor.resetPodoOnWriting()
//                    self.view.showPodoOnWriting(self.interactor.fetchPodoOnWriting(), mode: .create)
//                    self.view.showDefaultState()
//            }, onError: { error in
//                print(error)
//            })
//            .disposed(by: disposeBag)
    }

    func didTappedEdit() {
//        interactor.editPodo()!
//            .do {
//                gaEvent(GADefine.Podo, action: GADefine.editDone)
//                self.view.reloadRows(self.interactor.needUpdateIndexPaths, with: .automatic)
//            }
//            .flatMap { _ in
//                self.interactor.fetchPodolist()!
//            }
//            .observeOn(MainScheduler.instance)
//            .subscribe(
//                onNext: { _ in
//                    self.view.showPodolist()
//                    self.interactor.resetPodoOnWriting()
//                    self.view.showPodoOnWriting(self.interactor.fetchPodoOnWriting(), mode: .create)
//                    self.view.showDefaultState()
//            }, onError: { error in
//                print(error)
//            })
//            .disposed(by: disposeBag)
    }
}

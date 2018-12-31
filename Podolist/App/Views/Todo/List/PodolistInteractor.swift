//
//  PodolistInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol PodolistInteractorProtocol: class {

    // Presenter -> Interactor
    func fetchPodolist() -> Observable<[PodoSection]>?
    func createPodo() -> Observable<Podo>?
    func updatePodo(id: Int, podo: Podo) -> Observable<Podo>?
    func deletePodo(id: Int) -> Completable?
    func fetchAccount() -> Account

    // Top
    func updateSelectedDate(date: Date)

    // Cell
    func updateComplete(indexPath: IndexPath, completed: Bool) -> Observable<Podo>?

    // Writing
    func fetchPodoOnWriting() -> Podo
    func updateDate(date: Date)
    func updateTitle(title: String)
    func updatePriority(priority: Priority)
    func updatePodoOnWriting(_ podo: Podo)
    func resetPodoOnWriting()
}

class PodolistInteractor: PodolistInteractorProtocol {

    // MARK: - Properties

    private var podoDataSource: PodoDataSource
    private var accountDataSource: AccountDataSource

    private var podoSections = [PodoSection]()
    private var selectedDate = Date()
    private(set) var podo = Podo()

    init(
        podoDataSource: PodoDataSource,
        accountDataSource: AccountDataSource
        ) {
        self.podoDataSource = podoDataSource
        self.accountDataSource = accountDataSource
    }
}

extension PodolistInteractor {

    func fetchPodolist() -> Observable<[PodoSection]>? {
        return podoDataSource.findPodolist(page: 0, date: self.selectedDate)?
            .map {
                var podoSections = [PodoSection]()
                if CalendarUtils.isToday(date: self.selectedDate) {
                    if $0.delayedItems.isEmpty == false {
                        podoSections.append(PodoSection(title: InterfaceString.List.DelayedItems, rows: $0.delayedItems))
                    }
                    podoSections.append(PodoSection(title: InterfaceString.List.Items, rows: $0.items))
                } else {
                    podoSections.append(PodoSection(title: self.selectedDate.displayYYYYMMDD(), rows: $0.items))
                }
                self.podoSections = podoSections
                return podoSections
        }
    }

    func createPodo() -> Observable<Podo>? {
        return podoDataSource.addPodo(self.podo)
    }

    func updatePodo(id: Int, podo: Podo) -> Observable<Podo>? {
        return podoDataSource.savePodo(id: id, podo: podo)
    }

    func deletePodo(id: Int) -> Completable? {
        return podoDataSource.removePodo(id: id)
    }

    func fetchAccount() -> Account {
        return accountDataSource.findAccount()!
    }
}

// MARK: - Update Top

extension PodolistInteractor {

    func updateSelectedDate(date: Date) {
        self.selectedDate = date
    }
}

// MARK: - Update Cell

extension PodolistInteractor {

    func updateComplete(indexPath: IndexPath, completed: Bool) -> Observable<Podo>? {
        let podo = podoSections[indexPath.section].rows[indexPath.row]
        podo.isCompleted = completed
        return updatePodo(id: podo.id!, podo: podo)
    }
}

// MARK: - Update Writing

extension PodolistInteractor {

    func fetchPodoOnWriting() -> Podo {
        return self.podo
    }

    func updateTitle(title: String) {
        self.podo.title = title
    }

    func updatePriority(priority: Priority) {
        self.podo.priority = priority
    }

    func updateDate(date: Date) {
        self.podo.startedAt = date
        self.podo.endedAt = date
        self.podo.dueAt = date
    }

    func updatePodoOnWriting(_ podo: Podo) {
        self.podo = podo
    }

    func resetPodoOnWriting() {
        self.podo = Podo()
    }
}

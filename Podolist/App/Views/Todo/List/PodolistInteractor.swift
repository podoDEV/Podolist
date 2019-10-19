//
//  PodolistInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

protocol PodolistInteractorProtocol: class {

    // Presenter -> Interactor
    var podoSections: [PodoSection] { get }
    var writingMode: WritingMode { get }
    var selectedDate: Date { get }
    var selectedIndexPath: IndexPath? { get }
    var needUpdateIndexPaths: [IndexPath] { get }

    // CRUD
    func fetchPodolist() -> Observable<[PodoSection]>?
    func createPodo() -> Observable<Podo>?
    func updatePodo(id: Int, podo: Podo) -> Observable<Podo>?
    func deletePodo(id: Int) -> Completable?
    func fetchAccount() -> Account

    // Top
    func updateSelectedDate(date: Date)

    // Cell
    func updateComplete(indexPath: IndexPath, completed: Bool) -> Observable<Podo>?
    func editPodo() -> Observable<Podo>?
    func deletePodo(indexPath: IndexPath) -> Completable?
    func updateShowDelayedItems(show: Bool)
    func updateSelectedIndexPath(indexPath: IndexPath)

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

    private var showDelayedItems = true
    private var podo = Podo()
    var podoSections = [PodoSection]()
    var writingMode: WritingMode = .create
    var selectedDate = Date()
    var selectedIndexPath: IndexPath?
    var needUpdateIndexPaths: [IndexPath] = []

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
                        podoSections.append(PodoSection(title: InterfaceString.List.DelayedItems,
                                                        color: .delayedItems,
                                                        rows: $0.delayedItems,
                                                        editable: true,
                                                        visible: self.showDelayedItems))
                    }
                    podoSections.append(PodoSection(title: InterfaceString.List.Items,
                                                    color: .normalItems,
                                                    rows: $0.items))
                } else {
                    podoSections.append(PodoSection(title: self.selectedDate.displayYYYYMMDD(),
                                                    color: .normalItems,
                                                    rows: $0.items))
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

    func editPodo() -> Observable<Podo>? {
        if let selectedIndexPath = self.selectedIndexPath {
            self.needUpdateIndexPaths = [selectedIndexPath]
            self.selectedIndexPath = nil
        }
        return updatePodo(id: podo.id!, podo: podo)
    }

    func deletePodo(indexPath: IndexPath) -> Completable? {
        let id = podoSections[indexPath.section].rows[indexPath.row].id!
        podoSections[indexPath.section].rows.remove(at: indexPath.row)
        selectedIndexPath = nil
        return deletePodo(id: id)
    }

    func updateShowDelayedItems(show: Bool) {
        for section in podoSections where section.editable {
            section.visible = show
        }
        self.showDelayedItems = show
    }

    func updateSelectedIndexPath(indexPath selectedIndexPath: IndexPath) {
        if let prev = self.selectedIndexPath {
            if prev == selectedIndexPath {
                self.selectedIndexPath = nil
                self.needUpdateIndexPaths = [selectedIndexPath]
            } else {
                self.selectedIndexPath = selectedIndexPath
                self.needUpdateIndexPaths = [prev, selectedIndexPath]
            }
        } else {
            self.selectedIndexPath = selectedIndexPath
            self.needUpdateIndexPaths = [selectedIndexPath]
        }
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
        self.writingMode = .edit
        self.podo = podo.copy()
    }

    func resetPodoOnWriting() {
        self.writingMode = .create
        self.podo = Podo()
    }
}

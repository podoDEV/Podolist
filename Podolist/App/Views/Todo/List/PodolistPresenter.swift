//
//  PodolistPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift
import SwiftDate

protocol PodolistPresenterProtocol: class {
    // View -> Presenter
    func viewDidLoad()
    func reloadData()
    func didTouched()

    // Podolist
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func configureSection(_ cell: PodolistSectionCell, forSectionAt section: Int)
    func configureRow(_ cell: PodolistRowCell, forRowAt indexPath: IndexPath)
    func didSelect(indexPath: IndexPath)

    // Cell
    func didChangedComplete(indexPath: IndexPath, completed: Bool)
    func didTappedEdit(_ podo: Podo, indexPath: IndexPath)
    func didTappedDelete(indexPath: IndexPath)
    func didChangedShowDelayed(show: Bool)
}

final class PodolistPresenter: NSObject, PodolistPresenterProtocol {

    // MARK: - Properties

    private var view: PodolistViewProtocol!
    private var interactor: PodolistInteractorProtocol!
    private var wireFrame: PodolistWireFrameProtocol!

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(
        view: PodolistViewProtocol,
        wireframe: PodolistWireFrameProtocol,
        interactor: PodolistInteractorProtocol
        ) {
        self.view = view
        self.wireFrame = wireframe
        self.interactor = interactor
    }
}

// MARK: - PodolistPresenterProtocol

extension PodolistPresenter {

    func viewDidLoad() {
        view.showDefaultState()
        view.showProfile(interactor.fetchAccount())
        view.showPodoOnWriting(interactor.fetchPodoOnWriting(), mode: .create)
        reloadData()
    }

    func reloadData() {
        interactor.fetchPodolist()!
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podoSections in
                    self.view.showPodolist()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func didTouched() {
        if interactor.writingMode == .edit {
            interactor.resetPodoOnWriting()
            view.showPodoOnWriting(interactor.fetchPodoOnWriting(), mode: .create)
        }
        view.showDefaultState()
        view.hideMonthCalendar()
    }
}

// MARK: - Podolist

extension PodolistPresenter {

    func numberOfSections() -> Int {
        return interactor.podoSections.count
    }

    func numberOfRows(in section: Int) -> Int {
        let cell = interactor.podoSections[section]
        return cell.visible ? cell.rows.count : 0
    }

    func configureSection(_ cell: PodolistSectionCell, forSectionAt section: Int) {
        let item = interactor.podoSections[section]
        cell.configure(item.title, color: item.color, editable: item.editable, visible: item.visible)
        cell.presenter = self
    }

    func configureRow(_ cell: PodolistRowCell, forRowAt indexPath: IndexPath) {
        let podo = interactor.podoSections[indexPath.section].rows[indexPath.row]
        let isSelected = interactor.selectedIndexPath == indexPath
        cell.configureWith(podo, indexPath: indexPath, isSelected: isSelected)
        cell.selectionStyle = .none
        cell.presenter = self
    }

    func didSelect(indexPath: IndexPath) {
        interactor.updateSelectedIndexPath(indexPath: indexPath)
        view.reloadRows(interactor.needUpdateIndexPaths, with: .automatic)
    }
}

// MARK: - Update Cell

extension PodolistPresenter {

    func didChangedComplete(indexPath: IndexPath, completed: Bool) {
        interactor.updateComplete(indexPath: indexPath, completed: completed)!
            .flatMap { _ in
                self.interactor.fetchPodolist()!
            }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podoSections in
                    self.view.showPodolist()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func didTappedEdit(_ podo: Podo, indexPath: IndexPath) {
        interactor.updatePodoOnWriting(podo)
        view.showPodoOnWriting(podo, mode: interactor.writingMode)
        view.showWritingExpandState()
    }

    func didTappedDelete(indexPath: IndexPath) {
        interactor.deletePodo(indexPath: indexPath)!
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.view.deleteRows([indexPath], with: .fade)
                self?.view.reloadSections([0], with: .automatic)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func didChangedShowDelayed(show: Bool) {
        interactor.updateShowDelayedItems(show: show)
        view.reloadSections([0], with: .automatic)
    }
}

// MARK: - MonthCalendarViewDelegate

extension PodolistPresenter: MonthCalendarViewDelegate {

    func calendarView(_ calendarView: MonthCalendarView, didSelectDate date: Date) {
        view.showTopView(date)
        interactor.updateSelectedDate(date: date)
        reloadData()
    }
}

// MARK: - MainTopViewDelegate

extension PodolistPresenter: MainTopViewDelegate {

    func didTappedSetting() {
        wireFrame.navigate(to: .setting)
    }

    func didTappedMonthCalendar() {
        view.showMonthCalendar(interactor.selectedDate)
    }

    func didSelectDate(date: Date) {
        interactor.updateSelectedDate(date: date)
        reloadData()
    }
}

// MARK: - WriteViewDelegate

extension PodolistPresenter: WriteViewDelegate {

    func textFieldDidChange(text: String) {
        interactor.updateTitle(title: text)
    }

    func didChangedPriority(priority: Priority) {
        interactor.updatePriority(priority: priority)
    }

    func didChangedDate(date: Date) {
        interactor.updateDate(date: date)
    }

    func didTappedDetail() {
        view.showWritingExpandState()
    }

    func didTappedCreate() {
        interactor.createPodo()!
            .flatMap { _ in
                self.interactor.fetchPodolist()!
            }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { _ in
                    self.view.showPodolist()
                    self.interactor.resetPodoOnWriting()
                    self.view.showPodoOnWriting(self.interactor.fetchPodoOnWriting(), mode: .create)
                    self.view.showDefaultState()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func didTappedEdit() {
        interactor.editPodo()!
            .do {
                self.view.reloadRows(self.interactor.needUpdateIndexPaths, with: .automatic)
            }
            .flatMap { _ in
                self.interactor.fetchPodolist()!
            }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { _ in
                    self.view.showPodolist()
                    self.interactor.resetPodoOnWriting()
                    self.view.showPodoOnWriting(self.interactor.fetchPodoOnWriting(), mode: .create)
                    self.view.showDefaultState()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

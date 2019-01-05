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

    // Podolist
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func configureSection(_ cell: PodolistSectionCell, forSectionAt section: Int)
    func configureRow(_ cell: PodolistRowCell, forRowAt indexPath: IndexPath)

    // Cell
    func didChangedComplete(indexPath: IndexPath, completed: Bool)
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
        view.showPodoOnWriting(interactor.fetchPodoOnWriting())
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
        cell.configureWith(podo, indexPath: indexPath)
        cell.presenter = self
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

    func didTappedDelete(indexPath: IndexPath) {
        interactor.deletePodo(indexPath: indexPath)!
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.view.reloadRows([indexPath])
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func didChangedShowDelayed(show: Bool) {
        interactor.updateShowDelayedItems(show: show)
        view.reloadSection([0])
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
                onNext: { podoSections in
                    self.view.showPodolist()
                    self.interactor.resetPodoOnWriting()
                    self.view.showPodoOnWriting(self.interactor.fetchPodoOnWriting())
                    self.view.showDefaultState()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

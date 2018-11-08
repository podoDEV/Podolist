//
//  PodolistPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift
import SwiftDate

class PodolistPresenter: NSObject, PodolistPresenterProtocol {
    var view: PodolistViewProtocol?
    var interactor: PodolistInteractorProtocol?
    var wireFrame: PodolistWireFrameProtocol?

    let disposeBag = DisposeBag()

    var podoGroups: [PodoGroup] = []
    var date = Date()

    func refresh(date: Date) {
        self.date = date
        view?.updateUI()
        fetchPodolist(date: date)!
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podoGroups in
                    self.podoGroups = podoGroups
                    self.view?.showPodolist(with: podoGroups)
                }, onError: { error in
                    print(error)
                })
            .disposed(by: disposeBag)
    }

    func didTappedCreate(podo: Podo) {
        self.date = podo.startedAt
        interactor?.createPodo(podo: podo)!
            .flatMap { _ in self.fetchPodolist(date: self.date)! }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podoGroups in
                    self.podoGroups = podoGroups
                    self.view?.showPodolist(with: podoGroups)
                    self.view?.updateTopView(self.date)
                    self.view?.resetUI()
                    self.view?.updateUI()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func didTappedComplete(id: Int, completed: Bool) {
        var podo: Podo?
        for group in podoGroups {
            for item in group.1 where item.id == id {
                podo = item
                podo?.isCompleted = !completed
            }
        }
        guard podo != nil else { return }
        interactor?.updatePodo(id: id, podo: podo!)!
            .flatMap { _ in self.fetchPodolist(date: self.date)! }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podoGroups in
                    self.podoGroups = podoGroups
                    self.view?.showPodolist(with: podoGroups)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

extension PodolistPresenter {

    func showSetting() {
        wireFrame?.goToSettingScreen(from: view!)
    }
}

extension PodolistPresenter {

    func fetchPodolist(date: Date) -> Observable<[PodoGroup]>? {
        var observable: Observable<[PodoGroup]>?
        if CalendarUtils.isPast(date: date) {
            observable = interactor?.fetchPastPodolist(date: date)
        } else if CalendarUtils.isToday(date: date) {
            observable = interactor?.fetchTodayPodolist(date: date)
        } else if CalendarUtils.isFuture(date: date) {
            observable = interactor?.fetchFuturePodolist(date: date)
        }
        return observable
    }
}

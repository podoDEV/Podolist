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

    func refresh(date: Date) {
        view?.updateUI()
        var observable: Observable<[PodoGroup]>?
        if CalendarUtils.isPast(date: date) {
            observable = interactor?.fetchPastPodolist(date: date)
        } else if CalendarUtils.isToday(date: date) {
            observable = interactor?.fetchTodayPodolist(date: date)
        } else if CalendarUtils.isFuture(date: date) {
            observable = interactor?.fetchFuturePodolist(date: date)
        }

        observable?
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
        interactor?.createPodo(podo: podo)!
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podo in
//                    self.podolist.append(podo)
//                    self.view?.showPodolist(with: self.podolist)
//                    self.view?.updateTopView(podo.startedAt!)
                    self.view?.resetUI()
                    self.view?.updateUI()
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

//
//  PodolistPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodolistPresenter: NSObject, PodolistPresenterProtocol {
    var view: PodolistViewProtocol?
    var interactor: PodolistInteractorProtocol?
    var wireFrame: PodolistWireFrameProtocol?

    let disposeBag = DisposeBag()

    var podolist: [ViewModelPodo] = []
    var podoGroup: PodoGroup = [:]

    func refresh() {
        view?.updateUI()
        interactor?.fetchPodolist()!
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podolist in
                    self.podolist = podolist
                    self.view?.showPodolist(with: podolist)
                }, onError: { error in
                    print(error)
                })
            .disposed(by: disposeBag)
    }

    func refresh(date: Date) {
        view?.updateUI()
        var observable: Observable<PodoGroup>?
//        if date.isToday {
            observable = interactor?.fetchTodayPodolist(date: date)// fetchTodayPodolist()
//        }
//        else if 과거 {
//        }
//        else if 미래
//        }

        observable?
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podoGroup in
                    self.podoGroup = podoGroup
                    self.view?.showPodolist(with: podoGroup)
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
                    self.podolist.append(podo)
                    self.view?.showPodolist(with: self.podolist)
                    self.view?.updateTopView(podo.startedAt!)
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

extension PodolistPresenter {

    func fetchTodayPodolist() -> Observable<[ViewModelPodo]>? {
        return interactor?.fetchPodolist()
    }

    func fetchPastPodolist() -> Observable<[ViewModelPodo]>? {
        return interactor?.fetchPodolist()
    }

    func fetchFuturePodolist() -> Observable<[ViewModelPodo]>? {
        return interactor?.fetchPodolist()
    }
}

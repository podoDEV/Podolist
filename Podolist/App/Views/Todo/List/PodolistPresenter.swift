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

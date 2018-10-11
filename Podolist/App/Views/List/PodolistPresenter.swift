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
    var mode: Mode = .normal

    func refresh() {
        interactor?.fetchPodolist()?
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podolist in
                    self.podolist = podolist
                    self.view?.showPodolist(with: podolist)
                }, onError: { error in
                    print(error)
                }, onCompleted: {

                }, onDisposed: nil)
            .disposed(by: disposeBag)
        view?.updateUI(mode: mode)
    }

    func showSetting() {
        wireFrame?.goToSettingScreen(from: self.view!)
    }

    func didTappedWrite() {
        self.mode = .write
        view?.updateUI(mode: mode)
    }

    func didTappedDetail() {
        self.mode = .detail
        view?.updateUI(mode: mode)
    }

    func didTappedCreate(podo: Podo) {
        interactor?.createPodo(podo: podo)?
            .observeOn(MainScheduler.instance)
            .subscribe(
                onCompleted: {
                    self.refresh()
                }, onError: { error in

                })
            .disposed(by: disposeBag)
        // item create
        // item clear
//        interactor.
//        self.mode = .normal
//        view?.updateUI(mode: mode)
    }

    func writeWillFinish() {
        self.mode = .normal
        view?.updateUI(mode: mode)
    }
}

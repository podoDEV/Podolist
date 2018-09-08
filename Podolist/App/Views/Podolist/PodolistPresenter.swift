//
//  PodolistPresenter.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodolistPresenter: PodolistPresenterProtocol {
    var view: PodolistViewProtocol?
    var interactor: PodolistInteractorProtocol?
    var wireFrame: PodolistWireFrameProtocol?

    func viewDidLoad() {
        interactor?.fetchPodolist()?
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { podolist in
                self.view?.showPodolist(with: podolist)
            }, onError: { error in
                print(error)
            }, onCompleted: {

            }, onDisposed: {
                //                disposeBag.insert(self)
            })
    }
}

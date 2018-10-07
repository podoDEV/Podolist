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
        view?.updateUI(mode: mode, keyboardHeight: nil)
    }

    func viewWillAppear() {
        setupObserver()
    }

    func viewWillDisappear() {
        teardownObserver()
    }

    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)
    }

    func teardownObserver() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillAppear(notification: NSNotification?) {
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        self.mode = .write
        view?.updateUI(mode: mode, keyboardHeight: keyboardHeight)
    }

    @objc func keyboardWillDisappear(notification: NSNotification?) {
        self.mode = .normal
        view?.updateUI(mode: mode, keyboardHeight: nil)
    }

    func showSetting() {
        wireFrame?.goToSettingScreen(from: self.view!)
    }

    func writeWillFinish() {
        self.mode = .normal
        view?.updateUI(mode: mode, keyboardHeight: nil)
    }

    func modeWillChanged() {
        switch self.mode {
        case .normal:
            mode = .detail
        case .detail:
            mode = .normal
        default:
            break
        }
        view?.updateUI(mode: mode, keyboardHeight: nil)
    }

    func didTappedDetail() {
        self.mode = .detail
        view?.updateUI(mode: mode, keyboardHeight: nil)
    }
}

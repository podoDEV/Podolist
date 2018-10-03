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

    func viewWillAppear() {
        setupObserver()
    }

    func viewDidLoad() {
        view?.updateUI(mode: mode)
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

    func showSetting() {
        wireFrame?.goToSettingScreen(from: self.view!)
    }

    func writeWillFinish() {
        view?.updateUI(mode: .normal)
    }
}

extension PodolistPresenter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension PodolistPresenter {

    @objc func keyboardWillAppear(notification: NSNotification?) {
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        view?.updateUI(status: .show, keyboardHeight: keyboardHeight)
    }

    @objc func keyboardWillDisappear(notification: NSNotification?) {
        view?.updateUI(status: .hide, keyboardHeight: nil)
    }
}

enum KeyboardStatus {
    case show
    case hide
}

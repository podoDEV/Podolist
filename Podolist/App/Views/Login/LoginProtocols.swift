//
//  LoginProtocols.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }

    // Presenter -> View 
//    func showPodolist(with podolist: [ViewModelPodo])
}

extension LoginViewProtocol where Self: UIViewController {
    func showLoading() {

    }

    func hideLoading() {

    }
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }

    // View -> Presenter
    func viewDidLoad()
    //    func showWishDetail(from view: PodolistViewProtocol, forWish wish: ViewModelPodo)
//    func showSetting(from view: LoginViewProtocol)
}

protocol LoginInteractorProtocol: class {
    var dataSource: PodoDataSource? { get set }

    // Presenter -> Interactor
//    func fetchPodolist() -> Observable<[ViewModelPodo]>?
}

protocol LoginWireFrameProtocol: class {
    static func createLoginModule() -> UIViewController

    // Presenter -> WireFrame
    //    func presentPodoDetailScreen(from view: PodolistViewProtocol, forWish wish: ViewModel)
    //    func pushSettingScreen(from view: PodolistViewProtocol)
}

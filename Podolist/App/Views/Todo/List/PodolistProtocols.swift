//
//  PodolistProtocols.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift
import SwiftyJSON

protocol PodolistViewProtocol: class {
    var presenter: PodolistPresenterProtocol? { get set }

    // Presenter -> View 
    func showPodolist(with podolist: [ViewModelPodo])
    func updateUI()
    func updateUIToWrite()
    func updateUIToDetail()
    func resetUI()
}

extension PodolistViewProtocol where Self: UIViewController {
    func showLoading() {

    }

    func hideLoading() {

    }
}

protocol PodolistPresenterProtocol: class {
    var view: PodolistViewProtocol? { get set }
    var interactor: PodolistInteractorProtocol? { get set }
    var wireFrame: PodolistWireFrameProtocol? { get set }

    // View -> Presenter
    func refresh()
    func didTappedCreate(podo: Podo)
    func showSetting()
}

protocol PodolistInteractorProtocol: class {
    var dataSource: PodoDataSource? { get set }

    // Presenter -> Interactor
    func fetchPodolist() -> Observable<[ViewModelPodo]>?
    func createPodo(podo: Podo) -> Observable<ViewModelPodo>?
}

protocol PodolistWireFrameProtocol: class {
    static func createPodolistModule() -> UIViewController

    // Presenter -> WireFrame
    func goToSettingScreen(from view: PodolistViewProtocol)
}

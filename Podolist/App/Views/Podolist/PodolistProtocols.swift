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
    func viewDidLoad()
//    func showWishDetail(from view: PodolistViewProtocol, forWish wish: ViewModelPodo)
    func showSetting(from view: PodolistViewProtocol)
}

protocol PodolistInteractorProtocol: class {
    var dataSource: PodoDataSource? { get set }

    // Presenter -> Interactor
    func fetchPodolist() -> Observable<[ViewModelPodo]>?
}

protocol PodolistWireFrameProtocol: class {
    static func createPodolistModule() -> UIViewController

    // Presenter -> WireFrame
//    func presentPodoDetailScreen(from view: PodolistViewProtocol, forWish wish: ViewModel)
    func pushSettingScreen(from view: PodolistViewProtocol)
}

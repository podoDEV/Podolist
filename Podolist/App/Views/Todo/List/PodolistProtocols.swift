//
//  PodolistProtocols.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift
import SwiftDate
import SwiftyJSON

protocol PodolistViewProtocol: class {
    var presenter: PodolistPresenterProtocol? { get set }

    // Presenter -> View 
//    func showPodolist(with podolist: [ViewModelPodo])
    func showPodolist(with podoGroups: [PodoGroup])
    func updateUI()
    func updateUIToWrite()
    func updateUIToDetail()
    func updateTopView(_ date: Date)
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
//    func refresh()
    func refresh(date: Date)
    func didTappedCreate(podo: Podo)
    func didTappedComplete(id: Int, completed: Bool)
    func showSetting()
}

protocol PodolistInteractorProtocol: class {
    var dataSource: PodoDataSource? { get set }

    // Presenter -> Interactor
    func fetchPastPodolist(date: Date) -> Observable<[PodoGroup]>?
    func fetchTodayPodolist(date: Date) -> Observable<[PodoGroup]>?
    func fetchFuturePodolist(date: Date) -> Observable<[PodoGroup]>?
    func createPodo(podo: Podo) -> Observable<Podo>?
    func updatePodo(id: Int, podo: Podo) -> Observable<Podo>?
}

protocol PodolistWireFrameProtocol: class {
    static func createPodolistModule() -> UIViewController

    // Presenter -> WireFrame
    func goToSettingScreen(from view: PodolistViewProtocol)
}

typealias PodoGroup = (GroupHeader, [Podo])

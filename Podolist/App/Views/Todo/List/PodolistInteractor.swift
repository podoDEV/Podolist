//
//  PodolistInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodolistInteractor: PodolistInteractorProtocol {
    var dataSource: PodoDataSource?

    func fetchPastPodolist(date: Date) -> Observable<PodoGroup>? {
        let deleyed = delayedPodo(date: date)
        let completed = completedPodo(date: date)
        return Observable<PodoGroup>.zip(deleyed, completed) { delayed, completed -> PodoGroup in
            var result = PodoGroup()
            let delayedGroup = ViewModelPodoGroup(priority: 0, title: "delayed")
            let completedGroup = ViewModelPodoGroup(priority: 1, title: "completed")
            result.updateValue(delayed.map { ViewModelPodo(podo: $0) }, forKey: delayedGroup)
            result.updateValue(completed.map { ViewModelPodo(podo: $0) }, forKey: completedGroup)
            return result
        }
    }

    func fetchTodayPodolist(date: Date) -> Observable<PodoGroup>? {
        let deleyed = delayedPodo(date: date)
        let uncompleted = uncompletedPodo(date: date)
        let completed = completedPodo(date: date)
        return Observable<PodoGroup>.zip(deleyed, uncompleted, completed) { deleyed, uncompleted, completed -> PodoGroup in
            var result = PodoGroup()
            let delayedGroup = ViewModelPodoGroup(priority: 0, title: "delayed")
            let uncompletedGroup = ViewModelPodoGroup(priority: 1, title: "uncompleted")
            let completedGroup = ViewModelPodoGroup(priority: 2, title: "completed")
            result.updateValue(deleyed.map { ViewModelPodo(podo: $0) }, forKey: delayedGroup)
            result.updateValue(uncompleted.map { ViewModelPodo(podo: $0) }, forKey: uncompletedGroup)
            result.updateValue(completed.map { ViewModelPodo(podo: $0) }, forKey: completedGroup)
            return result
        }
    }

    func fetchFuturePodolist(date: Date) -> Observable<PodoGroup>? {
        let uncompleted = uncompletedPodo(date: date)
        return uncompleted.map { uncompleted -> PodoGroup in
            var result = PodoGroup()
            let uncompletedGroup = ViewModelPodoGroup(priority: 0, title: "uncompleted")
            result.updateValue(uncompleted.map { ViewModelPodo(podo: $0) }, forKey: uncompletedGroup)
            return result
        }
    }

    func fetchPodolist() -> Observable<[ViewModelPodo]>? {
        return dataSource?.findPodolist()!
            .map { podolist -> [ViewModelPodo] in
                return podolist.map { ViewModelPodo(podo: $0) }
            }
    }

    func createPodo(podo: Podo) -> Observable<ViewModelPodo>? {
        return dataSource?.addPodo(podo)!
            .flatMap { (self.dataSource?.findPodo(podoId: $0))! }
            .map { ViewModelPodo(podo: $0)}
    }
}

private extension PodolistInteractor {

    func completedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam = FilterParam(filterType: .complete, value: true)
        let dateParam = DateParam(dateType: .completedAt, value: date)
        let podoParams = PodoParams(filterParam: filterParam, dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }

    func uncompletedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam = FilterParam(filterType: .complete, value: false)
        let dateParam = DateParam(dateType: .dueAt, value: date)
        let podoParams = PodoParams(filterParam: filterParam, dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }

    func delayedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam = FilterParam(filterType: .delay, value: true)
        let dateParam = DateParam(dateType: .dueAt, value: date)
        let podoParams = PodoParams(filterParam: filterParam, dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }

    func undelayedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam = FilterParam(filterType: .delay, value: false)
        let dateParam = DateParam(dateType: .dueAt, value: date)
        let podoParams = PodoParams(filterParam: filterParam, dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }
}

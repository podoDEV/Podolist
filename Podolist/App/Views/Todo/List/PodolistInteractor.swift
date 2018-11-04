//
//  PodolistInteractor.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import RxSwift

class PodolistInteractor: PodolistInteractorProtocol {
    var dataSource: PodoDataSource?

    func fetchPastPodolist(date: Date) -> Observable<[PodoGroup]>? {
        let deleyed = delayedPodo(date: date)
        let completed = completedPodo(date: date)
        return Observable<[PodoGroup]>.zip(deleyed, completed) { delayed, completed -> [PodoGroup] in
            var result = [PodoGroup]()
            if delayed.isEmpty == false {
                let delayedGroup = ViewModelPodoGroup(title: "delayed")
                result.append(PodoGroup(delayedGroup, delayed.map { ViewModelPodo(podo: $0) }))
            }
            if completed.isEmpty == false {
                let completedGroup = ViewModelPodoGroup(title: "completed")
                result.append(PodoGroup(completedGroup, completed.map { ViewModelPodo(podo: $0) }))
            }
            return result
        }
    }

    func fetchTodayPodolist(date: Date) -> Observable<[PodoGroup]>? {
        let deleyed = uncompletedAndDelayedPodo(date: date)
        let uncompleted = uncompletedPodo(date: date)
        let completed = completedPodo(date: date)
        return Observable<[PodoGroup]>.zip(deleyed, uncompleted, completed) { delayed, uncompleted, completed -> [PodoGroup] in
            var result = [PodoGroup]()
            if delayed.isEmpty == false {
                let delayedGroup = ViewModelPodoGroup(title: "delayed")
                result.append(PodoGroup(delayedGroup, delayed.map { ViewModelPodo(podo: $0) }))
            }
            if uncompleted.isEmpty == false {
                let uncompletedGroup = ViewModelPodoGroup(title: "uncompleted")
                result.append(PodoGroup(uncompletedGroup, uncompleted.map { ViewModelPodo(podo: $0) }))
            }
            if completed.isEmpty == false {
                let completedGroup = ViewModelPodoGroup(title: "completed")
                result.append(PodoGroup(completedGroup, completed.map { ViewModelPodo(podo: $0) }))
            }
            return result
        }
    }

    func fetchFuturePodolist(date: Date) -> Observable<[PodoGroup]>? {
        let uncompleted = uncompletedPodo(date: date)
        var result = [PodoGroup]()
        return uncompleted.map { uncompleted -> [PodoGroup] in
            if uncompleted.isEmpty == false {
                let uncompletedGroup = ViewModelPodoGroup(title: "uncompleted")
                result.append(PodoGroup(uncompletedGroup, uncompleted.map { ViewModelPodo(podo: $0) }))
            }
            return result
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
        let podoParams = PodoParams(filterParams: [filterParam], dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }

    func uncompletedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam = FilterParam(filterType: .complete, value: false)
        let dateParam = DateParam(dateType: .dueAt, value: date)
        let podoParams = PodoParams(filterParams: [filterParam], dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }

    func delayedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam = FilterParam(filterType: .delay, value: true)
        let dateParam = DateParam(dateType: .dueAt, value: date)
        let podoParams = PodoParams(filterParams: [filterParam], dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }

    func undelayedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam = FilterParam(filterType: .delay, value: false)
        let dateParam = DateParam(dateType: .dueAt, value: date)
        let podoParams = PodoParams(filterParams: [filterParam], dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }

    func uncompletedAndDelayedPodo(date: Date) -> Observable<[Podo]> {
        let filterParam1 = FilterParam(filterType: .complete, value: false)
        let filterParam2 = FilterParam(filterType: .delay, value: true)
        let dateParam = DateParam(dateType: .dueAt, value: date)
        let podoParams = PodoParams(filterParams: [filterParam1, filterParam2], dateParam: dateParam)
        return (dataSource?.findPodolist(page: 0, params: podoParams))!
    }
}

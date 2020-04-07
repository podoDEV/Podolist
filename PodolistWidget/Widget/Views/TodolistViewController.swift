//
//  TodolistViewController.swift
//  PodolistWidget
//
//  Created by hb1love on 2020/03/24.
//  Copyright © 2020 podo. All rights reserved.
//

import UIKit
import NotificationCenter
import Core

class TodolistViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var todoTableView: UITableView!

    var todoService: TodoServiceType!

//    private var sections: [TodoSection] = []
    private var todos: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Core.setup()
        todoService = Core.todoService
        todoTableView.register(cell: TodoSectionCell.self)
        todoTableView.register(cell: TodoRowCell.self)
        reloadData()
    }

    func reloadData() {
        todoService.getTodos(page: 0, date: Date()) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let todolist):
                let delayed = todolist.delayedItems ?? []
                let items = todolist.items ?? []
                self.todos = delayed + items
//                self.sections = self.makeSections(todolist: todolist)
                self.todoTableView.reloadData()
            case .failure(let error):
                log.error(error.localizedDescription)
            }
        }
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        reloadData()

        completionHandler(NCUpdateResult.newData)
    }

}

extension TodolistViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
////        sections.count
//        todos.count
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
//        let section = sections[section]
//        return section.visible ? section.rows.count : 0
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell = tableView.dequeue(TodoSectionCell.self)!
//        cell.configure(sections[section])
//        return cell
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TodoRowCell.self)!
//        let item = sections[indexPath.section].rows[indexPath.row]
        cell.configure(todos[indexPath.row], indexPath: indexPath)
        return cell
    }
}

extension TodolistViewController {
    func makeSections(todolist: Todolist) -> [TodoSection] {
        var sections: [TodoSection] = []
        if let delayed = todolist.delayedItems, !delayed.isEmpty {
            sections.append(
                TodoSection(
                    title: "list.delayedItems".localized,
                    color: .delayedItems,
                    rows: delayed
                )
            )
        }
        sections.append(
            TodoSection(
                title: "list.items".localized,
                color: .normalItems,
                rows: todolist.items ?? []
            )
        )
        return sections
    }
}

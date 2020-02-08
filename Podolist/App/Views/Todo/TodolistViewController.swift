//
//  TodolistViewController.swift
//  Podolist
//
//  Created by hb1love on 2019/10/20.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Scope
import SnapKit

protocol TodolistViewProtocol: AnyObject {
    // MARK: - Presenter -> View
    func reloadData()
    func showTopView(_ date: Date)
    func showDefaultState()
    func showWritingExpandState()
    func showWritingTitleState()
    func showTodoOnWriting(_ todo: Todo, mode: WritingMode)
    func showMonthCalendar(_ date: Date)
    func hideMonthCalendar()
    func reloadSections(_ indexSet: IndexSet, with animation: UITableView.RowAnimation)
    func deleteRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func reloadRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
}

final class TodolistViewController: BaseViewController {

    // MARK: - Constants

    private struct Metric {
        static let topViewHeight = 133.f
        static let monthCalendarHeight = 400.f
        static let writeViewNormalHeight = 50.f
        static let writeViewExpandHeight = 330.f
        static let writeViewTotalHeight = 400.f
    }

    // MARK: - Subviews

    private var topView: MainTopView!
    private var monthCalendarView: MonthCalendarView!
    private var tableView: UITableView!
    private lazy var writeView: TodoWriteView = {
        let view = TodoWriteView(
            frame: CGRect(
                x: 0,
                y: self.view.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom,
                width: self.view.frame.width,
                height: Metric.writeViewTotalHeight
            )
        )
        if let delegate = presenter as? WriteViewDelegate {
            view.delegate = delegate
        }
        view.roundCorners([.topLeft, .topRight], radius: 17.25)
        view.backgroundColor = .backgroundColor1
        return view
    }()
    private lazy var writeHidingView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.5
        return view
    }()
    private lazy var monthCalendarHidingView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.5
        return view
    }()

    // MARK: - Properties

    var presenter: TodolistPresenterProtocol!
    private var keyboardHeight: CGFloat?

    private var normalFrame: CGRect {
        return CGRect(
            x: 0,
            y: view.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom,
            width: view.frame.width,
            height: Metric.writeViewNormalHeight + safeAreaInset.bottom
        )
    }
    private var writeFrame: CGRect {
        if let keyboardHeight = keyboardHeight {
            return CGRect(
                x: 0,
                y: view.frame.height - Metric.writeViewNormalHeight - keyboardHeight,
                width: view.frame.width,
                height: Metric.writeViewNormalHeight
            )
        }
        return normalFrame
    }
    private var detailWriteFrame: CGRect {
        return CGRect(
            x: 0,
            y: view.frame.height - Metric.writeViewExpandHeight - safeAreaInset.bottom,
            width: view.frame.width,
            height: Metric.writeViewExpandHeight + safeAreaInset.bottom
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.log(.main_view)
        presenter.viewDidLoad()
        showDefaultState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }

    override func setupSubviews() {
        topView = MainTopView().also {
            $0.delegate = presenter as? MainTopViewDelegate
            view.addSubview($0)
        }
        monthCalendarView = MonthCalendarView().also {
            $0.delegate = presenter as? MonthCalendarViewDelegate
            view.addSubview($0)
        }
        tableView = UITableView(frame: .zero, style: .grouped).also {
            $0.rowHeight = UITableView.automaticDimension
            $0.separatorStyle = .none
            $0.dataSource = self
            $0.delegate = self
            $0.backgroundColor = .white
            $0.sectionFooterHeight = 0
            $0.tableFooterView = UIView()
            $0.register(cell: TodolistSectionCell.self)
            $0.register(cell: TodolistRowCell.self)
            view.addSubview($0)
        }

        view.addSubview(writeView)
        view.addSubview(writeHidingView)
        view.addSubview(monthCalendarHidingView)
    }

    override func setupConstraints() {
        monthCalendarHidingView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height + safeAreaInset.bottom
        )
        monthCalendarView.frame = CGRect(
            x: 0,
            y: -Metric.monthCalendarHeight - safeAreaInset.top,
            width: view.bounds.width,
            height: Metric.monthCalendarHeight + safeAreaInset.top
        )
        topView.frame.size = CGSize(
            width: view.bounds.width,
            height: Metric.topViewHeight + safeAreaInset.top
        )
        tableView.frame = CGRect(
            x: 0,
            y: topView.frame.maxY,
            width: view.bounds.width,
            height: view.bounds.height - topView.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom
        )
        writeHidingView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height + safeAreaInset.bottom
        )
        writeView.frame = normalFrame
    }
}

extension TodolistViewController: TodolistViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }

    func showTopView(_ date: Date) {
        topView.update(date)
    }

    func showDefaultState() {
        view.bringSubviewToFront(writeView)
        monthCalendarHidingView.isHidden = true
        writeHidingView.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.normalFrame
        }
        writeView.updateUI()
        view.endEditing(true)
    }

    func showWritingTitleState() {
        writeHidingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.writeFrame
        }
        writeView.updateUIWriting()
    }

    func showWritingExpandState() {
        writeHidingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.detailWriteFrame
        }
        writeView.updateUIToDetail()
        view.endEditing(true)
    }

    func showMonthCalendar(_ date: Date) {
        view.bringSubviewToFront(monthCalendarHidingView)
        view.bringSubviewToFront(monthCalendarView)
        monthCalendarHidingView.isHidden = false
        monthCalendarView.update(date)
        UIView.animate(withDuration: 0.2) {
            self.monthCalendarView.frame.origin.y = 0
        }
    }

    func hideMonthCalendar() {
        monthCalendarHidingView.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.monthCalendarView.frame.origin.y = -Metric.monthCalendarHeight - self.safeAreaInset.top
        }
    }

    func reloadSections(_ indexSet: IndexSet, with animation: UITableView.RowAnimation) {
        tableView.beginUpdates()
        tableView.reloadSections(indexSet, with: animation)
        tableView.endUpdates()
    }

    func deleteRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths, with: animation)
        tableView.endUpdates()
    }

    func reloadRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView.beginUpdates()
        tableView.reloadRows(at: indexPaths, with: animation)
        tableView.endUpdates()
    }

    func showTodoOnWriting(_ todo: Todo, mode: WritingMode) {
        writeView.update(todo, mode: mode)
        view.endEditing(true)
    }
}

extension TodolistViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeue(TodolistSectionCell.self)!
        presenter.configureSection(cell, forSectionAt: section)
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TodolistRowCell.self)!
        presenter.configureRow(cell, forRowAt: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(indexPath: indexPath)
    }
}

extension TodolistViewController {

    @objc func keyboardWillAppear(notification: NSNotification?) {
        guard let keyboardFrame = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        keyboardHeight = keyboardFrame.cgRectValue.height
        presenter.keyboardWillShow()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter.didTouchedBackground()
    }
}

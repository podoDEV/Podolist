//
//  PodolistViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift
import SwiftDate

protocol PodolistViewProtocol: class {
    // Presenter -> View
    func showPodolist()
    func showProfile(_ account: Account)
    func showDefaultState()
    func showWritingExpandState()
    func showTopView(_ date: Date)
    func showPodoOnWriting(_ podo: Podo)
    func showMonthCalendar(_ date: Date)
    func reloadSection(_ indexSet: IndexSet)
}

class PodolistViewController: BaseViewController {

    // MARK: - Properties

    var presenter: PodolistPresenterProtocol!

    private var normalFrame: CGRect {
        return CGRect(x: 0,
                      y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom,
                      width: view.frame.width,
                      height: Style.Write.Normal.height + safeAreaInset.bottom)
    }
    private var writeFrame: CGRect {
        if let keyboardHeight = keyboardHeight {
            return CGRect(x: 0,
                          y: view.frame.height - Style.Write.Normal.height - keyboardHeight,
                          width: view.frame.width,
                          height: Style.Write.Normal.height)
        }
        return normalFrame
    }
    private var detailWriteFrame: CGRect {
        return CGRect(x: 0,
                      y: view.frame.height - Style.Write.Detail.height - safeAreaInset.bottom,
                      width: view.frame.width,
                      height: Style.Write.Detail.height + safeAreaInset.bottom)
    }
    private var keyboardHeight: CGFloat?

    // MARK: - Views

    private lazy var monthCalendarView: PodoMonthCalendarView = {
        let view = PodoMonthCalendarView()
        if let delegate = presenter as? PodoMonthCalendarViewDelegate {
            view.delegate = delegate
        }
        return view
    }()

    private lazy var topView: MainTopView = {
        let view = MainTopView()
        if let delegate = presenter as? MainTopViewDelegate {
            view.delegate = delegate
        }
        return view
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.sectionFooterHeight = 0
        view.tableFooterView = UIView()
        view.register(cell: PodolistSectionCell.self)
        view.registerNib(cell: PodolistRowCell.self)
        return view
    }()

    private lazy var writeView: PodoWriteView = {
        let view = PodoWriteView(frame: CGRect(x: 0,
                                               y: self.view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom,
                                               width: self.view.frame.width,
                                               height: 400/*total height*/))
        if let delegate = presenter as? WriteViewDelegate {
            view.delegate = delegate
        }
        view.roundCorners([.topLeft, .topRight], radius: 17.25)
        view.backgroundColor = .backgroundColor1
        return view
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        return control
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

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillAppear(notification: NSNotification?) {
        guard let keyboardFrame = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        keyboardHeight = keyboardFrame.cgRectValue.height
        showWritingTitleState()
    }

    override func setupSubviews() {
        super.setupSubviews()

        [monthCalendarView, topView, tableView, writeHidingView, writeView, monthCalendarHidingView].forEach(view.addSubview)
    }

    override func setupConstraints() {
        super.setupConstraints()
        monthCalendarHidingView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + safeAreaInset.bottom)
        monthCalendarView.frame = CGRect(x: 0, y: -400, width: view.bounds.width, height: 400 + safeAreaInset.top)
        topView.frame.size = CGSize(width: view.bounds.width, height: Style.List.Top.height + safeAreaInset.top)
        tableView.frame = CGRect(x: 0, y: topView.frame.maxY, width: view.bounds.width, height: view.bounds.height - topView.frame.height - Style.Write.Normal.height - safeAreaInset.bottom)
        writeHidingView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + safeAreaInset.bottom)
        writeView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showDefaultState()
        hideMonthCalendar()
        view.bringSubviewToFront(writeView)
    }
}

extension PodolistViewController: PodolistViewProtocol {

    func showPodolist() {
        tableView.reloadData()
    }

    func showProfile(_ account: Account) {
        topView.updateProfile(account)
    }

    func showDefaultState() {
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
    }

    func showWritingExpandState() {
        writeHidingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.detailWriteFrame
        }
        writeView.updateUIToDetail()
        view.endEditing(true)
    }

    func showTopView(_ date: Date) {
        topView.update(date)
    }

    func showPodoOnWriting(_ podo: Podo) {
        writeView.update(podo)
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
        writeHidingView.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.monthCalendarView.frame.origin.y = -400 - self.safeAreaInset.top
        }
    }

    func reloadSection(_ indexSet: IndexSet) {
        tableView.beginUpdates()
        tableView.reloadSections(indexSet, with: .top)
        tableView.endUpdates()
    }
}

extension PodolistViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeue(PodolistSectionCell.self)!
        presenter.configureSection(cell, forSectionAt: section)
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(PodolistRowCell.self)!
        presenter.configureRow(cell, forRowAt: indexPath)
        return cell
    }

    func scrollToBottom() {
//        let indexPath = IndexPath(row: podoGroup.count - 1, section: 0)
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension PodolistViewController: UITableViewDelegate {

}

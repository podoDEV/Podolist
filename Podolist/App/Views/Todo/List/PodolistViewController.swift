//
//  PodolistViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

import RxSwift
import Scope
import SnapKit
import SwiftDate

protocol PodolistViewProtocol: class {
    // Presenter -> View
    func showPodolist()
    func showProfile(_ account: Account)
    func showDefaultState()
    func showWritingExpandState()
    func showTopView(_ date: Date)
    func showPodoOnWriting(_ podo: Podo, mode: WritingMode)
    func showMonthCalendar(_ date: Date)
    func reloadSections(_ indexSet: IndexSet, with animation: UITableView.RowAnimation)
    func deleteRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func reloadRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
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
    private var writeFrame2: CGRect {
        if let keyboardHeight = keyboardHeight {
            return CGRect(x: 0,
                          y: view.frame.height - Style.Write.Normal.height - keyboardHeight - 40,
                          width: view.frame.width,
                          height: 60)
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

    private lazy var monthCalendarView: MonthCalendarView = {
        let view = MonthCalendarView()
        if let delegate = presenter as? MonthCalendarViewDelegate {
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
        view.register(cell: PodolistRowCell.self)
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
    private let isEditingView = UIView()
    private let editingText = UILabel()
    private let cancelButton = UIButton()

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

        with(isEditingView) {
            $0.alpha = 0.8
        }

        with(editingText) {
            $0.font = .appFontM(size: 13)
            $0.textColor = .white
            $0.text = InterfaceString.Edit.Editing
        }
        with(cancelButton) {
            $0.titleLabel?.font = .appFontM(size: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.setTitle(InterfaceString.Edit.Cancel, for: .normal)
            $0.titleEdgeInsets = .zero
            $0.addTarget(self, action: #selector(didCancelEdit), for: .touchUpInside)
        }

        isEditingView.backgroundColor = .gray
        [cancelButton, editingText].forEach(isEditingView.addSubview)
        [monthCalendarView, topView, tableView, writeHidingView, writeView, isEditingView, monthCalendarHidingView].forEach(view.addSubview)
        view.bringSubviewToFront(writeView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        monthCalendarHidingView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + safeAreaInset.bottom)
        monthCalendarView.frame = CGRect(x: 0, y: -400, width: view.bounds.width, height: 400 + safeAreaInset.top)
        topView.frame.size = CGSize(width: view.bounds.width, height: Style.List.Top.height + safeAreaInset.top)
        tableView.frame = CGRect(x: 0, y: topView.frame.maxY, width: view.bounds.width, height: view.bounds.height - topView.frame.height - Style.Write.Normal.height - safeAreaInset.bottom)
        writeHidingView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + safeAreaInset.bottom)
        writeView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
        isEditingView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom - 40, width: view.frame.width, height: 60)

        editingText.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
//            $0.height.equalTo(14)
//            $0.width.equalTo(40)
        }

        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(editingText)
//            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-15)
//            $0.height.equalTo($0)
//            $0.width.height.equalTo(14)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showDefaultState()
        hideMonthCalendar()
        view.bringSubviewToFront(writeView)
    }

    @objc func didCancelEdit() {
        presenter.didCancelEdit()
    }
}

// MARK: - PodolistViewProtocol

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
            self.isEditingView.frame = CGRect(x: 0, y: self.view.frame.height - Style.Write.Normal.height - self.safeAreaInset.bottom - 40, width: self.view.frame.width, height: 60)
        }
        writeView.updateUI()
        view.endEditing(true)
    }

    func showWritingTitleState() {
        writeHidingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.writeFrame
            self.isEditingView.frame = self.writeFrame2
        }
    }

    func showWritingExpandState() {
        writeHidingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.detailWriteFrame
            self.isEditingView.frame = CGRect(x: 0, y: self.view.frame.height - Style.Write.Detail.height - self.safeAreaInset.bottom - 40, width: self.view.frame.width, height: 60)
        }
        writeView.updateUIToDetail()
        view.endEditing(true)
    }

    func showTopView(_ date: Date) {
        topView.update(date)
    }

    func showPodoOnWriting(_ podo: Podo, mode: WritingMode) {
        writeView.update(podo, mode: mode)
        view.endEditing(true)
        switch mode {
        case .create:
            isEditingView.isHidden = true
        case .edit:
            isEditingView.isHidden = false
        }
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
            self.monthCalendarView.frame.origin.y = -400 - self.safeAreaInset.top
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
}

// MARK: - UITableViewDataSource

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(indexPath: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension PodolistViewController: UITableViewDelegate {

}

//
//  PodolistView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift
import SwiftDate

class PodolistView: BaseViewController {
    var presenter: PodolistPresenterProtocol?
    private var podo: Podo = Podo()
    private var podoGroups: [PodoGroup] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var normalFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
    }
    private var writeFrame: CGRect {
        if let keyboardHeight = keyboardHeight {
            return CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - keyboardHeight, width: view.frame.width, height: Style.Write.Normal.height)
        }
        return normalFrame
    }
    private var detailWriteFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Detail.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Detail.height + safeAreaInset.bottom)
    }
    private var keyboardHeight: CGFloat?

    // MARK: - Views
    private var topView: MainTopView!
    private var tableView: UITableView!
    private var writeView: PodoWriteView!
    private var refreshControl: UIRefreshControl!
    private var hidingView: UIView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter?.refresh(date: Date())
    }

    override func setupSubviews() {
        super.setupSubviews()
        setupTopView()
        setupTableView()
        setupHidingView()
        setupWriteView()
    }

    func setupTopView() {
        topView = MainTopView()
        topView.delegate = self
        view.addSubview(topView)
    }

    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.sectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: PodolistSectionCell.Identifier, bundle: nil), forCellReuseIdentifier: PodolistSectionCell.Identifier)
        tableView.register(UINib(nibName: PodolistRowCell.Identifier, bundle: nil), forCellReuseIdentifier: PodolistRowCell.Identifier)
//        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
    }

    func setupHidingView() {
        hidingView = UIView()
        hidingView.backgroundColor = .gray
        hidingView.alpha = 0.5
        view.addSubview(hidingView)
    }

    func setupWriteView() {
        writeView = PodoWriteView(frame: CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: 400/*total height*/))
        writeView.delegate = self
        writeView.roundCorners([.topLeft, .topRight], radius: 17.25)
        writeView.backgroundColor = .backgroundColor1
        view.addSubview(writeView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        topView.frame.size = CGSize(width: view.bounds.width, height: Style.List.Top.height + safeAreaInset.top)
        tableView.frame = CGRect(x: 0, y: topView.frame.maxY, width: view.bounds.width, height: view.bounds.height - topView.frame.height - Style.Write.Normal.height - safeAreaInset.bottom)
        hidingView.frame = tableView.frame
        writeView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }

    @objc func keyboardWillAppear(notification: NSNotification?) {
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        keyboardHeight = keyboardFrame.cgRectValue.height
        updateUIToWrite()
    }

//    @objc func refresh(_ sender: Any) {
//        presenter?.refresh()
//        refreshControl.endRefreshing()
//    }
}

extension PodolistView: PodolistViewProtocol {

    func showPodolist(with podoGroups: [PodoGroup]) {
        self.podoGroups = podoGroups
        hideLoading()
    }

    func updateUI() {
        hidingView.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.normalFrame
        }
        writeView.updateUI()
        view.endEditing(true)
    }

    func updateUIToWrite() {
        hidingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.writeFrame
        }
    }

    func updateUIToDetail() {
        hidingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.detailWriteFrame
        }
        writeView.updateUIToDetail()
        view.endEditing(true)
    }

    func updateTopView(_ date: Date) {
        topView.update(date)
    }

    func resetUI() {
        podo = Podo()
        writeView.update(podo)
        view.endEditing(true)
        scrollToBottom()
    }

    func showError() {
        hideLoading()
    }
}

extension PodolistView: MainTopViewDelegate {

    func didTappedSetting() {
        presenter?.showSetting()
    }

    func didSelectDate(date: Date) {
        presenter?.refresh(date: date)
    }
}

extension PodolistView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return podoGroups.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podoGroups[section].1.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodolistSectionCell.Identifier) as! PodolistSectionCell

        let group = podoGroups[section].0
        cell.item = group

        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodolistRowCell.Identifier, for: indexPath) as! PodolistRowCell

        let podo = podoGroups[indexPath.section].1[indexPath.row]
        cell.item = podo
        cell.presenter = presenter

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func scrollToBottom() {
//        let indexPath = IndexPath(row: podoGroup.count - 1, section: 0)
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension PodolistView: WriteViewDelegate {

    func textFieldDidChange(text: String) {
        podo.title = text
    }

    func didChangedPriority(priority: Priority) {
        podo.priority = priority
    }

    func didChangedDate(date: Date) {
        podo.startedAt = date
        podo.endedAt = date
    }

    func didTappedDetail() {
        updateUIToDetail()
    }

    func didTappedCreate() {
        presenter?.didTappedCreate(podo: self.podo)
        gaAction("New Todo")
    }

    // TODO: - 필요하지 않을수도 있음.
    func didTappedExit() {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateUI()
    }
}

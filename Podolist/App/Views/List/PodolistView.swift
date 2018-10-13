//
//  PodolistView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

class PodolistView: BaseViewController {
    var presenter: PodolistPresenterProtocol?
    var podo: Podo = Podo()
    var podolist: [ViewModelPodo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var normalFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
    }
    var writeFrame: CGRect {
        if let keyboardHeight = keyboardHeight {
            return CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - keyboardHeight, width: view.frame.width, height: Style.Write.Normal.height)
        }
        return normalFrame
    }
    var detailWriteFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Detail.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Detail.height + safeAreaInset.bottom)
    }
    var keyboardHeight: CGFloat?

    // MARK: - Views
    var topView: MainTopView!
    var tableView: UITableView!
    var writeView: PodoWriteView!
    var refreshControl: UIRefreshControl!
    var hidingView: UIView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter?.refresh()
    }

    override func setup() {
        super.setup()
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
        tableView = UITableView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: PodolistTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: PodolistTableViewCell.Identifier)
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
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

    override func setupFrame() {
        super.setupFrame()
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

    @objc func refresh(_ sender: Any) {
        presenter?.refresh()
        refreshControl.endRefreshing()
    }

    @IBAction func pressSetting(_ sender: Any) {
        presenter?.showSetting()
    }
}

extension PodolistView: PodolistViewProtocol {

    func showPodolist(with podolist: [ViewModelPodo]) {
        self.podolist = podolist
        hideLoading()
    }

    func updateUI() {
        hidingView.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.writeView.frame = self.normalFrame
        }
        writeView.updateUI()
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
    }

    func resetUI() {
        podo = Podo()
        writeView.clear()
        view.endEditing(true)
        scrollToBottom()
    }

    func showError() {
        hideLoading()
    }
}

extension PodolistView: MainTopViewDelegate {

    func didSelectDate(date: Date) {
        presenter?.refresh()
    }
}

extension PodolistView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podolist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodolistTableViewCell.Identifier, for: indexPath) as! PodolistTableViewCell

        let podo = podolist[indexPath.row]
        cell.item = podo

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func scrollToBottom() {
        let indexPath = IndexPath(row: podolist.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension PodolistView: WriteViewDelegate {

    func textFieldDidChange(text: String) {
        podo.title = text
    }

    func dateDidChange(date: Date) {
        podo.startedAt = Int(date.timeIntervalSince1970)
        podo.endedAt = Int(date.timeIntervalSince1970)
    }

    func didTappedDetail() {
        updateUIToDetail()
        view.endEditing(true)
    }

    func didTappedCreate() {
        presenter?.didTappedCreate(podo: self.podo)
    }

    // TODO: - 필요하지 않을수도 있음.
    func didTappedExit() {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateUI()
        view.endEditing(true)
    }
}

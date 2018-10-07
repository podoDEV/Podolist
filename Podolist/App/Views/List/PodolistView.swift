//
//  PodolistView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift
import PodoCalendar

class PodolistView: BaseViewController {
    var presenter: PodolistPresenterProtocol?
    var podolist: [ViewModelPodo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var normalFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
    }
    var detailWriteFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Detail.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Detail.height + safeAreaInset.bottom)
    }

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
        topView.title = "August"
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
        tableView.frame = CGRect(x: 0, y: topView.frame.maxY, width: view.bounds.width, height: view.bounds.height - topView.frame.height)
        hidingView.frame = tableView.frame
        writeView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc func refresh(_ sender: Any) {
        presenter?.refresh()
        refreshControl.endRefreshing()
    }
}

extension PodolistView: WriteViewDelegate {

    func didTappedDetail() {
        presenter?.didTappedDetail()
    }

    func didTappedSend() {

    }

    @IBAction func pressSetting(_ sender: Any) {
        presenter?.showSetting()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter?.writeWillFinish()
    }
}

extension PodolistView: PodolistViewProtocol {

    func showPodolist(with podolist: [ViewModelPodo]) {
        self.podolist = podolist
        hideLoading()
    }

    func showError() {
        hideLoading()
    }

    func updateUI(mode: Mode, keyboardHeight: CGFloat? = nil) {
        switch mode {
        case .normal:
            hidingView.isHidden = true
            UIView.animate(withDuration: 0.2) {
                self.writeView.frame = self.normalFrame
            }
            view.endEditing(true)
        case .write:
            hidingView.isHidden = false
            guard let keyboardHeight = keyboardHeight else {
                return
            }
            writeView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - keyboardHeight, width: view.frame.width, height: Style.Write.Normal.height)
        case .detail:
            hidingView.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.writeView.frame = self.detailWriteFrame
            }
        }
        writeView.mode = mode
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
}

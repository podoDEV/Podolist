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
            podolistTableView.reloadData()
        }
    }
    var safeAreaInset: UIEdgeInsets = .zero {
        didSet {
            writeView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
        }
    }

    var normalFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Normal.height + safeAreaInset.bottom)
    }

    var detailWriteFrame: CGRect {
        return CGRect(x: 0, y: view.frame.height - Style.Write.Detail.height - safeAreaInset.bottom, width: view.frame.width, height: Style.Write.Detail.height + safeAreaInset.bottom)
    }

    // MARK: - Views
    @IBOutlet weak var podolistTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    lazy var writeView: PodoWriteView = {
        let view = PodoWriteView(frame: CGRect(x: 0, y: self.view.frame.height - Style.Write.Normal.height - safeAreaInset.bottom, width: self.view.frame.width, height: 400/*total height*/))
        view.delegate = self
        return view
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter?.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        podolistTableView.rowHeight = UITableViewAutomaticDimension
        podolistTableView.separatorStyle = .none
        podolistTableView.dataSource = self
        podolistTableView.delegate = self
        podolistTableView.tableFooterView = UIView()
        podolistTableView.register(UINib(nibName: PodolistTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: PodolistTableViewCell.Identifier)

        writeView.roundCorners([.topLeft, .topRight], radius: 17.25)
        writeView.backgroundColor = .backgroundColor1
        self.view.addSubview(writeView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        safeAreaInset = view.layoutInsets()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
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
            emptyView.isHidden = true
            UIView.animate(withDuration: 0.3) {
                self.writeView.frame = self.normalFrame
            }
            view.endEditing(true)
        case .write:
            emptyView.isHidden = false
            guard let keyboardHeight = keyboardHeight else {
                return
            }
            writeView.frame = CGRect(x: 0, y: view.frame.height - Style.Write.Normal.height - keyboardHeight, width: view.frame.width, height: Style.Write.Normal.height)
        case .detail:
            emptyView.isHidden = false
            UIView.animate(withDuration: 0.3) {
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

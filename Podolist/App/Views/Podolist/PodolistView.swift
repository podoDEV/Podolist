//
//  PodolistView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

class PodolistView: UIViewController {
    var presenter: PodolistPresenterProtocol?
    var podolist: [ViewModelPodo] = []
    var mode: Mode = .normal {
        didSet {
            updateUI(mode)
        }
    }

    @IBOutlet weak var podolistTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var floatingButton: RoundButton!
    var writeView: PodoWriteView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        setupUI()
        setupData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        teardownObserver()
    }

    func setupUI() {
        podolistTableView.tableFooterView = UIView()
    }

    func setupData() {
        presenter?.viewDidLoad()
    }

    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)
    }

    func teardownObserver() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    func updateUI(_ mode: Mode) {
        switch mode {
        case .normal:
            emptyView.isHidden = true
            floatingButton.isHidden = false
        case .write:
            emptyView.isHidden = false
            floatingButton.isHidden = true
            let cgRect = CGRect(x: 0, y: view.frame.height - Style.Podo.Write.height, width: view.frame.width, height: Style.Podo.Write.height)
            writeView = PodoWriteView(frame: cgRect, delegate: presenter)
            view.addSubview(writeView!)
        }
    }
}

extension PodolistView {

    @IBAction func tappedNew(_ sender: Any) {
        mode = .write
    }

    @IBAction func tappedSetting(_ sender: Any) {
        presenter?.showSetting()
    }
}

extension PodolistView: PodolistViewProtocol {

    func showPodolist(with podolist: [ViewModelPodo]) {
        self.podolist = podolist
        podolistTableView.reloadData()
        hideLoading()
    }

    func showError() {
        hideLoading()
    }
}

extension PodolistView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodoTableViewCell.Identifier, for: indexPath) as! PodoTableViewCell

        let podo = podolist[indexPath.row]
        cell.set(forPodo: podo)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podolist.count
    }
}

extension PodolistView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.showWishDetail(from: self, forWish: wishes[indexPath.row])
    }
}

extension PodolistView: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        writeView?.removeFromSuperview()
        mode = .normal
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(writeView?.titleField) {
            writeView?.titleField.resignFirstResponder()
        }
        return true
    }

    @objc func keyboardWillAppear(notification: NSNotification?) {
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        writeView?.y = view.frame.height - Style.Podo.Write.height - keyboardHeight
        writeView?.height = Style.Podo.Write.height
    }

    @objc func keyboardWillDisappear(notification: NSNotification?) {
        var safeAreaInset = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            safeAreaInset = view.safeAreaInsets
        }
        writeView?.y = self.view.bounds.height - Style.Podo.Write.height - safeAreaInset.bottom
        writeView?.height = Style.Podo.Write.height + safeAreaInset.bottom
    }

    enum Mode {
        case normal
        case write
    }
}

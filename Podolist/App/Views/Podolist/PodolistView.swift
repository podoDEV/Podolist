//
//  PodolistView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

class PodolistView: BaseView {
    var presenter: PodolistPresenterProtocol?
    var podolist: [ViewModelPodo] = [] {
        didSet {
            podolistTableView.reloadData()
        }
    }

    @IBOutlet weak var podolistTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var floatingButton: RoundButton!
    var writeView: PodoWriteView?
    var calendarView: PodoCalendar?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        setupUI()
        presenter?.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }

    @IBAction func pressCal(_ sender: Any) {
        calendarView = PodoCalendar(frame: CGRect(x: 0, y: view.bounds.height - Style.Podo.Calendar.height, width: view.bounds.width, height: Style.Podo.Calendar.height))
        view.addSubview(calendarView!)
    }

    @IBAction func pressSetting(_ sender: Any) {
        calendarView = PodoCalendar(frame: CGRect(x: 0, y: view.bounds.height - Style.Podo.Calendar.height, width: view.bounds.width, height: Style.Podo.Calendar.height))
        view.addSubview(calendarView!)
//        presenter?.showSetting()
    }
}

extension PodolistView {

    func setupUI() {
        podolistTableView.dataSource = self
        podolistTableView.delegate = presenter as? UITableViewDelegate
        podolistTableView.tableFooterView = UIView()
        floatingButton.delegate = presenter as? RoundButtonDelegate
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

    func updateUI(mode: Mode) {
        switch mode {
        case .normal:
            emptyView.isHidden = true
            floatingButton.isHidden = false
            if let writeView = writeView {
                writeView.removeFromSuperview()
            }
            view.endEditing(true)
        case .write:
            emptyView.isHidden = false
            floatingButton.isHidden = true
            writeView = PodoWriteView(frame: CGRect(x: 0, y: view.bounds.height - Style.Podo.Write.height, width: view.bounds.width, height: Style.Podo.Write.height))
            writeView?.delegate = self
            view.addSubview(writeView!)
        }
    }

    func updateUI(status: KeyboardStatus, keyboardHeight: CGFloat?) {
        switch status {
        case .show:
            guard let keyboardHeight = keyboardHeight else {
                return
            }
            writeView?.y = view.frame.height - Style.Podo.Write.height - keyboardHeight
            writeView?.height = Style.Podo.Write.height
        case .hide:
            var safeAreaInset = UIEdgeInsets.zero
            if #available(iOS 11.0, *) {
                safeAreaInset = view.safeAreaInsets
            }
            writeView?.y = self.view.bounds.height - Style.Podo.Write.height - safeAreaInset.bottom
            writeView?.height = Style.Podo.Write.height + safeAreaInset.bottom
        }
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

extension PodolistView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(writeView?.titleField) {
            writeView?.titleField.resignFirstResponder()
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter?.writeWillFinish()
    }
}

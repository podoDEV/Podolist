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

    @IBOutlet weak var podolistTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    private let writeView = PodoWriteView().loadNib() as! PodoWriteView
    var safeAreaInset: UIEdgeInsets = .zero

    //    var calendarView: PodoCalendarView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter?.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        safeAreaInset = view.layoutInsets()
        writeView.frame = CGRect(x: 0, y: view.bounds.height - Style.Podo.Write.height - safeAreaInset.bottom, width: view.bounds.width, height: Style.Podo.Write.height + safeAreaInset.bottom)
        writeView.roundCorners([.topLeft, .topRight], radius: 17.25)
        writeView.delegate = self
    }

    override func setupUI() {
        super.setupUI()
        podolistTableView.rowHeight = UITableViewAutomaticDimension
        podolistTableView.separatorStyle = .none
        podolistTableView.dataSource = self
        podolistTableView.delegate = presenter as? UITableViewDelegate
        podolistTableView.tableFooterView = UIView()
        podolistTableView.register(UINib(nibName: PodolistTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: PodolistTableViewCell.Identifier)
        view.addSubview(writeView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }

    @IBAction func pressCal(_ sender: Any) {
//        calendarView = PodoCalendarView(frame: CGRect(x: 0, y: view.bounds.height - Style.Podo.Calendar.height, width: view.bounds.width, height: Style.Podo.Calendar.height))
//        view.addSubview(calendarView!)
    }

    @IBAction func pressSetting(_ sender: Any) {
//        calendarView = PodoCalendarView(frame: CGRect(x: 0, y: view.bounds.height - Style.Podo.Calendar.height, width: view.bounds.width, height: Style.Podo.Calendar.height))
//        calendarView?.delegate = self
//        view.addSubview(calendarView!)
        presenter?.showSetting()
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
//            floatingButton.isHidden = false
//            if let writeView = writeView {
//                writeView.removeFromSuperview()
//            }
            view.endEditing(true)
        case .detail:
            emptyView.isHidden = false
//            floatingButton.isHidden = true
            writeView.frame = CGRect(x: 0, y: view.bounds.height - Style.Podo.Write.height, width: view.bounds.width, height: Style.Podo.Write.height)
//            view.bounds.height - Style.Podo.Write.height - safeAreaInset.bottom
//            view.addSubview(writeView!)
        }
    }

    func updateUI(status: KeyboardStatus, keyboardHeight: CGFloat?) {
        switch status {
        case .show:
            emptyView.isHidden = false
            guard let keyboardHeight = keyboardHeight else {
                return
            }
            writeView.frame.origin.y = view.frame.height - Style.Podo.Write.height - keyboardHeight
            writeView.frame.size.height = Style.Podo.Write.height
        case .hide:
            emptyView.isHidden = true
            writeView.frame.origin.y = view.bounds.height - Style.Podo.Write.height - safeAreaInset.bottom
            writeView.frame.size.height = Style.Podo.Write.height + safeAreaInset.bottom
        }
    }
}

extension PodolistView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podolist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodolistTableViewCell.Identifier, for: indexPath) as! PodolistTableViewCell

        let podo = podolist[indexPath.row]
        cell.item = podo

        return cell
    }
}

extension PodolistView: UITextViewDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField.isEqual(writeView?.titleField) {
//            writeView?.titleField.resignFirstResponder()
//        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter?.writeWillFinish()
    }
}

extension PodolistView: PodoCalendarViewDelegate {
    func calendarView(_ calendarView: PodoCalendarView, startedAt startDate: Date, finishedAt finishDate: Date) {
    }

    func calendarView(_ calendarView: PodoCalendarView, didSelectDate date: Date) {
        print(date.toString())
    }
}

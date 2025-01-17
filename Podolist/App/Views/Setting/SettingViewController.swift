//
//  SettingViewController.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Scope
import SnapKit

protocol SettingViewProtocol: AnyObject {
    // MARK: - Presenter -> View
    func reloadData()
}

class SettingViewController: BaseViewController {

    // MARK: - Subviews

    private var tableView: UITableView!

    // MARK: - Properties

    var presenter: SettingPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.log(.settings_view)
        presenter?.viewDidLoad()
    }

    override func setupSubviews() {
        title = "setting".localized
        tableView = UITableView(frame: .zero, style: .grouped).also {
            $0.estimatedRowHeight = 300
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .white
            $0.isScrollEnabled = false
            $0.tableFooterView = UIView()
            $0.register(cell: SettingCell.self)
            $0.register(cell: SettingAccountCell.self)
            view.addSubview($0)
        }
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Presenter -> View
extension SettingViewController: SettingViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueTableCell(indexPath)
        presenter.configureCell(cell as! SettingCellType, forRowAt: indexPath)
        return cell
    }

    func dequeueTableCell(_ indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.rows[indexPath.row]
        if item is SettingAccountRow {
            return tableView.dequeue(SettingAccountCell.self)!
        }
        return tableView.dequeue(SettingCell.self)!
    }
}

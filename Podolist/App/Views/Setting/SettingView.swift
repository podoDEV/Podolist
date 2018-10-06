//
//  SettingView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

class SettingView: BaseViewController {

    @IBOutlet weak var settingTableView: UITableView!
    var presenter: SettingPresenterProtocol?
    var settings: [ViewModelSettingSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        showLoading()
    }

    override func setupUI() {
        super.setupUI()
        settingTableView.tableFooterView = UIView()
        settingTableView.register(UINib(nibName: SettingTableViewLogoutCell.Identifier, bundle: nil), forCellReuseIdentifier: SettingTableViewLogoutCell.Identifier)
        settingTableView.register(UINib(nibName: SettingTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: SettingTableViewCell.Identifier)
    }
}

extension SettingView: SettingViewProtocol {

    func showSettings(with settings: [ViewModelSettingSection]) {
        self.settings = settings
        settingTableView.reloadData()
        hideLoading()
    }

    func showError() {
        hideLoading()
    }
}

extension SettingView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].sectionTitle
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].rowCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = settings[indexPath.section]
        switch item.type {
        case .account:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.Identifier, for: indexPath) as? SettingTableViewCell, let item = item as? ViewModelSettingAccountItem {
                cell.item = item.row
                return cell
            }
        case .others:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.Identifier, for: indexPath) as? SettingTableViewCell, let item = item as? ViewModelSettingOthersItem {
                cell.item = item.rows[indexPath.row]
                return cell
            }
        case .logout:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewLogoutCell.Identifier, for: indexPath) as? SettingTableViewLogoutCell, let item = item as? ViewModelSettingLogoutItem {
                cell.item = item.row
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension SettingView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = settings[indexPath.section]
        var type: SettingRowType?
        switch item.type {
        case .account:
            type = .account
        case .others:
            guard let item = item as? ViewModelSettingOthersItem else {
                return
            }
            type = item.rows[indexPath.row].type
        case .logout:
            type = .logout
        }
        showView(type!)
    }

    func showView(_ type: SettingRowType) {
        switch type {
        case .account,
             .help,
             .about:
            presenter?.showDetail(type: type)
        case .sync:
            break
        case .logout:
            presenter?.logout()
        }
    }
}

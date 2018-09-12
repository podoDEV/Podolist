//
//  SettingView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

class SettingView: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    var presenter: SettingPresenterProtocol?
    var settings: [Setting] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.tableFooterView = UIView()

        presenter?.viewDidLoad()
        showLoading()
    }
}

extension SettingView: SettingViewProtocol {

    func showSettings(with settings: [Setting]) {
        self.settings = settings
        settingTableView.reloadData()
        hideLoading()
    }

    func showError() {
        hideLoading()
    }
}

extension SettingView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.Identifier, for: indexPath) as! SettingTableViewCell

        let setting = settings[indexPath.row]
        cell.set(forSetting: setting)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
}

extension SettingView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        presenter?.showWishDetail(from: self, forWish: wishes[indexPath.row])
    }
}

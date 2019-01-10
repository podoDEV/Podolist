//
//  SettingViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

protocol SettingViewProtocol: class {

}

class SettingViewController: BaseViewController {

    // MARK: - Properties

    var presenter: SettingPresenterProtocol!

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.sectionFooterHeight = 0
        view.isScrollEnabled = false
        view.tableFooterView = UIView()
        view.register(cell: SettingTableViewCell.self)
        view.register(cell: SettingTableViewAccountCell.self)
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter?.viewDidLoad()
    }

    override func setupSubviews() {
        super.setupSubviews()
        setupNavigationBar()
        setupTableView()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = InterfaceString.Setting.Title
    }

    func setupTableView() {
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.navigationBar.setGradientBackground(colors: [.gradationStart, .gradationEnd])
    }

    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
    }
}

// MARK: - SettingViewProtocol

extension SettingViewController: SettingViewProtocol {

}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF0E5FE)
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 32
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueTableCell(indexPath)
        presenter.configureCell(cell as! SettingCellType, forRowAt: indexPath)
        return cell
    }

    func dequeueTableCell(_ indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.sections[indexPath.section]
        if let item = item as? SettingInfoSection, item.rows[indexPath.row].type == .account {
            return tableView.dequeue(SettingTableViewAccountCell.self)!
        }
        return tableView.dequeue(SettingTableViewCell.self)!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.sections[section].sectionTitle
    }
}

//
//  SettingViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

protocol SettingViewProtocol: class {
    var presenter: SettingPresenterProtocol? { get set }
}

class SettingViewController: BaseViewController, SettingViewProtocol {

    // MARK: - SettingViewProtocol

    var presenter: SettingPresenterProtocol?

    // MARK: - Views

    private var tableView: UITableView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.sectionFooterHeight = 0
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(cell: SettingTableViewCell.self)
        tableView.register(cell: SettingTableViewAccountCell.self)
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.navigationBar.setGradientBackground(colors: [.gradationStart, .gradationEnd])
        tableView.frame = view.bounds
    }
}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter?.sections.count)!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.numberOfRows(in: section))!
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
        presenter?.configureCell(cell as! SettingCellType, forRowAt: indexPath)
        return cell
    }

    func dequeueTableCell(_ indexPath: IndexPath) -> UITableViewCell {
        let item = presenter?.sections[indexPath.section]
        if let item = item as? SettingInfoSection, item.rows[indexPath.row].type == .account {
            return tableView.dequeue(SettingTableViewAccountCell.self)!
        }
        return tableView.dequeue(SettingTableViewCell.self)!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.sections[section].sectionTitle
    }
}

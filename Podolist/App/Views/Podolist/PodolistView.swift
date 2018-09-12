//
//  PodolistView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

class PodolistView: UIViewController {

    @IBOutlet weak var podolistTableView: UITableView!
    var presenter: PodolistPresenterProtocol?
    var podolist: [ViewModelPodo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        podolistTableView.tableFooterView = UIView()

        presenter?.viewDidLoad()
        showLoading()
    }

    // MARK: - Action
    @IBAction func tappedSetting(_ sender: Any) {
        presenter?.showSetting(from: self)
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

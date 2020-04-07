//
//  BaseViewController.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Core

class BaseViewController: UIViewController {
    var safeAreaInset: UIEdgeInsets = .zero {
        didSet {
            setupConstraints()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupNavigationBar()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        safeAreaInset = view.layoutInsets()
    }

    func setupSubviews() {}
    func setupConstraints() {}
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .appColor1
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

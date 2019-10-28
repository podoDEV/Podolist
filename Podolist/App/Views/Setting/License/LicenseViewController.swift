//
//  LicenseViewController.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Scope
import SnapKit

class LicenseViewController: BaseViewController {
    private var licenseView: UITextView!

    override func setupSubviews() {
        setupNavigationBar()
        title = "setting.license".localized
        licenseView = UITextView().also {
            $0.text = String(urlOfResourceFile: "license.txt")
            $0.font = .appFontL(size: 14)
            view.addSubview($0)
        }
    }

    override func setupConstraints() {
        licenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

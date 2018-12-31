//
//  LicenseViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class LicenseViewController: BaseViewController {

    var licenseView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupSubviews() {
        super.setupSubviews()
        setupNavigationBar()
        setupLicenseView()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = InterfaceString.Setting.License
    }

    func setupLicenseView() {
        licenseView = UITextView(frame: .zero)
        licenseView.text = String(urlOfResourceFile: "license.txt")
        licenseView.font = .appFontL(size: 14)
        view.addSubview(licenseView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        licenseView.translatesAutoresizingMaskIntoConstraints = false
        licenseView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        licenseView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

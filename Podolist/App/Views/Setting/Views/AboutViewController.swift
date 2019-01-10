//
//  AboutViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    private var logoImageView: UIImageView!
    private var nameLabel: UILabel!
    private var versionLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var copyrightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupSubviews() {
        super.setupSubviews()
        setupNavigationBar()
        setupAboutView()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = InterfaceString.Setting.About
    }

    func setupAboutView() {
        logoImageView = UIImageView(frame: .zero)
        logoImageView.image = InterfaceImage.logo.normalImage
        view.addSubview(logoImageView)

        nameLabel = UILabel(frame: .zero)
        nameLabel.text = InterfaceString.Commmon.Podolist
        nameLabel.textColor = .black
        nameLabel.font = .appFontM(size: 16)
        view.addSubview(nameLabel)

        versionLabel = UILabel(frame: .zero)
        versionLabel.text = AppUtils.versionName()
        versionLabel.textColor = .gray3
        versionLabel.font = .appFontL(size: 14)
        view.addSubview(versionLabel)

        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.text = String(urlOfResourceFile: "intro.txt")
        descriptionLabel.textColor = .gray3
        descriptionLabel.font = .appFontL(size: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.lineBreakMode = .byTruncatingTail
        view.addSubview(descriptionLabel)

        copyrightLabel = UILabel(frame: .zero)
        copyrightLabel.text = InterfaceString.Signature.Copyright
        copyrightLabel.textColor = .gray3
        copyrightLabel.font = .appFontL(size: 13)
        view.addSubview(copyrightLabel)
    }

    override func setupConstraints() {
        super.setupConstraints()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 94).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 86).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        versionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 50).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        copyrightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

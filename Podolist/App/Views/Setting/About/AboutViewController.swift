//
//  AboutViewController.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Core
import Scope
import SnapKit

class AboutViewController: BaseViewController {

    // MARK: - Constants

    private struct Metric {
        static let logoTop = 200.f
        static let logoHeight = 94.f
        static let logoWidth = 86.f
        static let nameTop = 30.f
        static let nameHeight = 20.f
        static let versionTop = 7.f
        static let versionHeight = 20.f
        static let descriptionTop = 50.f
        static let descriptionLeading = 40.f
        static let descriptionBottom = 60.f
        static let copyrightBottom = 30.f
    }

    // MARK: - Subviews

    private var logoView: UIImageView!
    private var nameLabel: UILabel!
    private var versionLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var copyrightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.log(.about_view)
    }

    override func setupSubviews() {
        title = "setting.about".localized
        view.backgroundColor = .white
        logoView = UIImageView().also {
            $0.image = InterfaceImage.logo.image
            view.addSubview($0)
        }
        nameLabel = UILabel().also {
            $0.text = "common.podolist".localized
            $0.textColor = .black
            $0.font = .appFontM(size: 17)
            view.addSubview($0)
        }
        versionLabel = UILabel().also {
            $0.text = AppUtils.versionName()
            $0.textColor = .gray3
            $0.font = .appFontL(size: 15)
            view.addSubview($0)
        }
        descriptionLabel = UILabel().also {
            $0.text = String(urlOfResourceFile: "intro.txt")
            $0.textColor = .gray3
            $0.font = .appFontL(size: 14)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byTruncatingTail
            $0.textAlignment = .center
            view.addSubview($0)
        }
        copyrightLabel = UILabel().also {
            $0.text = "signature.copyright".localized
            $0.textColor = .gray3
            $0.font = .appFontL(size: 13)
            view.addSubview($0)
        }
    }

    override func setupConstraints() {
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.logoTop)
            $0.width.equalTo(Metric.logoWidth)
            $0.height.equalTo(Metric.logoHeight)
            $0.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(Metric.nameTop)
            $0.height.equalTo(Metric.nameHeight)
            $0.centerX.equalToSuperview()
        }
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Metric.versionTop)
            $0.height.equalTo(Metric.versionHeight)
            $0.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(Metric.descriptionTop)
            $0.leading.equalToSuperview().offset(Metric.descriptionLeading)
            $0.trailing.equalToSuperview().offset(-Metric.descriptionLeading)
        }
        copyrightLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Metric.copyrightBottom)
            $0.centerX.equalToSuperview()
        }
    }
}

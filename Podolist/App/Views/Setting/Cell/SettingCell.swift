//
//  SettingCell.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Scope
import SnapKit

protocol SettingCellType {
    func configure(with item: SettingRowProtocol)
}

final class SettingCell: BaseTableViewCell, SettingCellType {

    // MARK: - Constants

    private struct Metric {
        static let thumbnailLeading = 24.f
        static let thumbnailTopBottom = 18.f
        static let thumbnailWH = 18.f
        static let titleLeading = 22.f
        static let titleHeight = 16.f
        static let titleWidth = 150.f
    }

    // MARK: - Subviews

    private var thumbnailView: UIImageView!
    private var titleLabel: UILabel!

    override func setupSubviews() {
        selectionStyle = .none
        thumbnailView = UIImageView().also {
            contentView.addSubview($0)
        }
        titleLabel = UILabel().also {
            $0.font = .appFontL(size: 13)
            $0.textColor = .black
            $0.sizeToFit()
            contentView.addSubview($0)
        }
    }

    override func setupConstraints() {
        thumbnailView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Metric.thumbnailLeading)
            $0.top.equalToSuperview().offset(Metric.thumbnailTopBottom)
            $0.bottom.equalToSuperview().offset(-Metric.thumbnailTopBottom)
            $0.width.height.equalTo(Metric.thumbnailWH)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailView.snp.trailing).offset(Metric.titleLeading)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(Metric.titleHeight)
            $0.width.equalTo(Metric.titleWidth)
        }
    }

    func configure(with item: SettingRowProtocol) {
        thumbnailView.image = item.image
        titleLabel.text = item.title

        switch item.type {
        case .about,
             .license:
            accessoryType = .disclosureIndicator
        default:
            break
        }
    }
}

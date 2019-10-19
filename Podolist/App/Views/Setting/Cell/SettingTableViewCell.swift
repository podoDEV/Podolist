//
//  SettingTableViewCell.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol SettingCellType {
    func configure(with item: SettingRowProtocol)
}

final class SettingTableViewCell: UITableViewCell, SettingCellType {

    // MARK: - Views

    private let thumbnailView = UIImageView()
    private let titleLabel = UILabel()
    private let separateView = UIView()

    // MARK: - Initialize

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        selectionStyle = .none
        addSubview(thumbnailView)

        titleLabel.font = .appFontL(size: 13)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        addSubview(titleLabel)

        separateView.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        addSubview(separateView)
    }

    func setupConstraints() {
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        thumbnailView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        thumbnailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
        thumbnailView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        thumbnailView.heightAnchor.constraint(equalTo: thumbnailView.widthAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 22).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

        separateView.translatesAutoresizingMaskIntoConstraints = false
        separateView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separateView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separateView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
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

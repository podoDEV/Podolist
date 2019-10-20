//
//  SettingAccountCell.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Scope
import SnapKit

final class SettingAccountCell: BaseTableViewCell, SettingCellType {

    // MARK: - Subviews

    private var thumbnailView: UIImageView!
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        thumbnailView.clipsToBounds = true
//        thumbnailView.layer.cornerRadius = thumbnailView.bounds.width/2
//    }

    override func setupSubviews() {
        thumbnailView = UIImageView().also {
            $0.clipsToBounds = true
            contentView.addSubview($0)
        }
    }

    override func setupConstraints() {

    }

//    func setupUI() {
//        selectionStyle = .none
//
//        addSubview(thumbnailView)
//
//        nameLabel.font = .appFontL(size: 18)
//        nameLabel.textColor = .black
//        nameLabel.sizeToFit()
//        addSubview(nameLabel)
//
//        emailLabel.font = .appFontL(size: 13)
//        emailLabel.textColor = .black
//        addSubview(emailLabel)
//
//        separateView.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
//        addSubview(separateView)
//    }
//
//    func setupConstraints() {
//        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
//        thumbnailView.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
//        thumbnailView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
//        thumbnailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
//        thumbnailView.widthAnchor.constraint(equalToConstant: 54).isActive = true
//        thumbnailView.heightAnchor.constraint(equalTo: thumbnailView.widthAnchor).isActive = true
//
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 32).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//
////        nameLabel.translatesAutoresizingMaskIntoConstraints = false
////        nameLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 32).isActive = true
////        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
////        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
////        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
////
////        emailLabel.translatesAutoresizingMaskIntoConstraints = false
////        emailLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 32).isActive = true
////        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 9).isActive = true
////        emailLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -25).isActive = true
////        emailLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
////        emailLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//
//        separateView.translatesAutoresizingMaskIntoConstraints = false
//        separateView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        separateView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        separateView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        separateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
//    }

    func configure(with item: SettingRowProtocol) {
        thumbnailView.image = item.image
        if let item = item as? SettingAccountRowProtocol {
            nameLabel.text = item.name
            emailLabel.text = item.email
        }
    }
}

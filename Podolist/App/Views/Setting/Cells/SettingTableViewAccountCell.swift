//
//  SettingTableViewAccountCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class SettingTableViewAccountCell: UITableViewCell, SettingCellType {

    // MARK: - Views

    private let thumbnailView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let separateView = UIView()

    // MARK: - Initialize

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailView.clipsToBounds = true
        thumbnailView.layer.cornerRadius = thumbnailView.bounds.width/2
    }

    func setupUI() {
        selectionStyle = .none

        addSubview(thumbnailView)

        nameLabel.font = .appFontL(size: 18)
        nameLabel.textColor = .black
        nameLabel.sizeToFit()
        addSubview(nameLabel)

        emailLabel.font = .appFontL(size: 13)
        emailLabel.textColor = .black
        addSubview(emailLabel)

        separateView.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        addSubview(separateView)
    }

    func setupConstraints() {
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        thumbnailView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        thumbnailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        thumbnailView.widthAnchor.constraint(equalToConstant: 54).isActive = true
        thumbnailView.heightAnchor.constraint(equalTo: thumbnailView.widthAnchor).isActive = true

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 32).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 32).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//
//        emailLabel.translatesAutoresizingMaskIntoConstraints = false
//        emailLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 32).isActive = true
//        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 9).isActive = true
//        emailLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -25).isActive = true
//        emailLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
//        emailLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

        separateView.translatesAutoresizingMaskIntoConstraints = false
        separateView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separateView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separateView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

    func configureWith(_ item: SettingRowProtocol) {
        thumbnailView.image = item.image
        if let item = item as? SettingAccountRowProtocol {
            nameLabel.text = item.name
            emailLabel.text = item.email
        }
    }
}

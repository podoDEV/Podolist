//
//  LoginButton.swift
//  Podolist
//
//  Created by NHNEnt on 24/11/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import SnapKit

final class LoginButton: UIButton {

    private var containerView: UIView!
    private var iconImage: UIImageView!
    private var textLabel: UILabel!

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        containerView = UIView(frame: .zero)
        containerView.isUserInteractionEnabled = false
        containerView.backgroundColor = .clear
        addSubview(containerView)

        iconImage = UIImageView()
        containerView.addSubview(iconImage)

        textLabel = UILabel()
        textLabel.font = .appFontR(size: 14)
        textLabel.textColor = .black
        textLabel.sizeToFit()
        containerView.addSubview(textLabel)
    }

    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.height.equalTo(iconImage.snp.height)
            $0.center.equalTo(snp.center)
        }

        iconImage.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading)
            $0.height.width.equalTo(27)
            $0.centerY.equalToSuperview()
        }

        textLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(6)
            $0.trailing.equalTo(containerView.snp.trailing)
            $0.height.equalTo(27)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(image: UIImage?, title: String, color: UIColor) {
        iconImage.image = image
        textLabel.text = title
        backgroundColor = color
    }
}

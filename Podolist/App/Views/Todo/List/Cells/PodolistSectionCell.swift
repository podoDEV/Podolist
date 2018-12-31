//
//  PodolistSectionCell.swift
//  Podolist
//
//  Created by NHNEnt on 02/11/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit
import SnapKit

class PodolistSectionCell: UITableViewHeaderFooterView {

    // MARK: - Metric

    private struct Metric {

    }

    // MARK: - Properties

    weak var presenter: PodolistPresenterProtocol?

    private let titleLabel = UILabel()
    private let caretButton = UIButton()
    private let caretImageView = UIImageView()

    private var editable: Bool?
    private var visible: Bool?

    // MARK: - Initializer

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ title: String, color: UIColor, editable: Bool, visible: Bool) {
        titleLabel.text = title
        titleLabel.textColor = color

        if editable {
            caretImageView.isHidden = false
            caretButton.isHidden = false
            if visible {
                caretImageView.image = UIImage(named: "ic_caretDelayedClose")
            } else {
                caretImageView.image = UIImage(named: "ic_caretDelayedOpen")
            }
        } else {
            caretImageView.isHidden = true
            caretButton.isHidden = true
        }
        self.editable = editable
        self.visible = visible
    }
}

private extension PodolistSectionCell {

    func setupSubviews() {
        contentView.backgroundColor = .white
        titleLabel.font = .appFontB(size: 13)

        caretButton.addTarget(self, action: #selector(didTappedCaret(_:)), for: .touchUpInside)

        caretImageView.isUserInteractionEnabled = false

        [caretImageView].forEach(caretButton.addSubview)
        [titleLabel, caretButton].forEach(contentView.addSubview)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.height.equalTo(16)
        }

        caretButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalTo(34)
        }

        caretImageView.snp.makeConstraints {
            $0.width.equalTo(9)
            $0.height.equalTo(5)
            $0.centerX.centerY.equalToSuperview()
        }
    }

    @objc func didTappedCaret(_ sender: Any) {
        self.visible?.toggle()
        presenter?.didChangedShowDelayed(show: self.visible!)
    }
}

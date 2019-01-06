//
//  PodolistRowCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

import Scope
import SnapKit

class PodolistRowCell: UITableViewCell {

    // MARK: - Metric

    private struct Metric {

    }

    // MARK: - Properties

    weak var presenter: PodolistPresenterProtocol?
    private var podo: Podo?
    private var indexPath: IndexPath?

    private var completeContainerView: UIView!
    private var priorityView: UIView!
    private var completeImageView: UIImageView!
    private var titleContainerView: UIView!
    private var titleLabel: UILabel!
    private var editImageView: UIButton!
    private var deleteImageView: UIButton!

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PodolistRowCell {

    func setupSubviews() {
        completeContainerView = UIView().also {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedComplete))
            $0.addGestureRecognizer(tap)
            addSubview($0)
        }
        priorityView = UIView().also {
            $0.layer.cornerRadius = 9
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = false
            completeContainerView.addSubview($0)
        }
        completeImageView = UIImageView().also {
            $0.image = InterfaceImage.complete.normalImage
            $0.isUserInteractionEnabled = false
            completeContainerView.addSubview($0)
        }
        titleContainerView = UIView().also {
            $0.layer.cornerRadius = 17.25
            $0.clipsToBounds = true
            addSubview($0)
        }
        titleLabel = UILabel().also {
            $0.textColor = .white
            $0.font = .appFontR(size: 12)
            $0.numberOfLines = 0
            titleContainerView.addSubview($0)
        }
        editImageView = UIButton().also {
            $0.setImage(UIImage(named: "ic_edit"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
            $0.addTarget(self, action: #selector(didTappedEdit), for: .touchUpInside)
            titleContainerView.addSubview($0)
        }
        deleteImageView = UIButton().also {
            $0.setImage(UIImage(named: "ic_delete"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
            $0.addTarget(self, action: #selector(didTappedDelete), for: .touchUpInside)
            titleContainerView.addSubview($0)
        }
    }

    func setupConstraints() {
        completeContainerView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.top.bottom.equalTo(titleContainerView)
            $0.width.equalTo(42)
        }
        priorityView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-9)
            $0.width.height.equalTo(18)
        }
        completeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-9)
            $0.centerY.equalToSuperview().offset(-1.5)
            $0.width.height.equalTo(15)
        }
        titleContainerView.snp.makeConstraints {
            $0.leading.equalTo(completeContainerView.snp.trailing)
            $0.top.greaterThanOrEqualToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview().offset(5)
            $0.trailing.lessThanOrEqualToSuperview().offset(-40)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        editImageView.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleContainerView.snp.trailing)
        }
        deleteImageView.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleContainerView.snp.trailing).offset(16)
        }
    }
}

extension PodolistRowCell {

    func configureWith(_ podo: Podo, indexPath: IndexPath, isSelected: Bool) {
        self.podo = podo
        self.indexPath = indexPath
        titleLabel.text = podo.title
        update()

        if isSelected {
            self.addOptionsView()
        } else {
            self.removeOptionsView()
        }
    }

    func update() {
        guard let podo = self.podo else { return }
        if podo.isCompleted {
            completeImageView.isHidden = false
            priorityView.backgroundColor = .backgroundColor2
            priorityView.layer.borderColor = UIColor.backgroundColor2.cgColor
            titleContainerView.backgroundColor = .todoBackground2
        } else {
            completeImageView.isHidden = true
            priorityView.backgroundColor = .white
            priorityView.layer.borderColor = podo.priority.backgroundColor().cgColor
            priorityView.layer.borderWidth = 1.5
            titleContainerView.backgroundColor = .todoBackground1
        }
    }

    func addOptionsView() {
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(editImageView.snp.leading).offset(-14)
        }
        editImageView.snp.remakeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(deleteImageView.snp.leading).offset(-12)
        }
        deleteImageView.snp.remakeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-14)
        }
        layoutIfNeeded()
    }

    func removeOptionsView() {
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        editImageView.snp.remakeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleContainerView.snp.trailing)
        }
        deleteImageView.snp.remakeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleContainerView.snp.trailing).offset(16)
        }
        layoutIfNeeded()
    }

    @objc func didTappedComplete() {
        guard let podo = self.podo, let indexPath = self.indexPath else { return }
        podo.isCompleted.toggle()
        update()
        presenter?.didChangedComplete(indexPath: indexPath, completed: podo.isCompleted)
    }

    @objc func didTappedEdit() {
        guard let indexPath = self.indexPath else { return }
        presenter?.didTappedEdit(podo!, indexPath: indexPath)
    }

    @objc func didTappedDelete() {
        guard let indexPath = self.indexPath else { return }
        presenter?.didTappedDelete(indexPath: indexPath)
    }
}

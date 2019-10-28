//
//  TodolistRowCell.swift
//  Podolist
//
//  Created by hb1love on 2019/10/20.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import Scope
import SnapKit

class TodolistRowCell: UITableViewCell {

    // MARK: - Constants

    private struct Metric {

    }

    // MARK: - Properties

    weak var presenter: TodolistPresenterProtocol?
    private var todo: Todo?
    private var indexPath: IndexPath?

    private var completeContainerView: UIView!
    private var priorityView: UIView!
    private var completeImageView: UIImageView!
    private var titleContainerView: UIView!
    private var titleLabel: UILabel!
    private var editImageView: UIButton!
    private var deleteImageView: UIButton!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    func configure(_ todo: Todo, indexPath: IndexPath, isSelected: Bool) {
        self.todo = todo
        self.indexPath = indexPath
        titleLabel.text = todo.title
        update()

        if isSelected {
            self.addOptionsView()
        } else {
            self.removeOptionsView()
        }
    }

    func update() {
        guard let todo = self.todo else { return }
        if todo.isCompleted == true {
            completeImageView.isHidden = false
            priorityView.backgroundColor = .backgroundColor2
            priorityView.layer.borderColor = UIColor.backgroundColor2.cgColor
            titleContainerView.backgroundColor = .todoBackground2
        } else {
            completeImageView.isHidden = true
            priorityView.backgroundColor = .white
            priorityView.layer.borderColor = todo.priority?.backgroundColor().cgColor
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
        guard let completed = self.todo?.isCompleted,
            let indexPath = self.indexPath else { return }

        self.todo?.isCompleted = !completed
        update()
        presenter?.didChangedComplete(indexPath: indexPath, completed: !completed)
    }

    @objc func didTappedEdit() {
        guard let indexPath = self.indexPath else { return }
        guard let todo = self.todo else { return }
        presenter?.didTappedEdit(todo, indexPath: indexPath)
    }

    @objc func didTappedDelete() {
        guard let indexPath = self.indexPath else { return }
        presenter?.didTappedDelete(indexPath: indexPath)
    }
}

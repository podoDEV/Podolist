////
////  TodoRowCell.swift
////  TodayExtension
////
////  Created by hb1love on 2020/03/20.
////  Copyright © 2020 podo. All rights reserved.
////
//
//import UIKit
//import Core
//import Scope
//import SnapKit
//
//final class TodoRowCell: UITableViewCell {
//
//    // MARK: - Constants
//
//    private struct Metric {
//
//    }
//
//    // MARK: - Properties
//
//    private var todo: Todo?
//
//    private var completeContainerView: UIView!
//    private var priorityView: UIView!
//    private var completeImageView: UIImageView!
//    private var titleContainerView: UIView!
//    private var titleLabel: UILabel!
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupSubviews()
//        setupConstraints()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupSubviews() {
//        completeContainerView = UIView().also {
//            let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedComplete))
//            $0.addGestureRecognizer(tap)
//            addSubview($0)
//        }
//        priorityView = UIView().also {
//            $0.backgroundColor = .clear
//            $0.layer.cornerRadius = 9
//            $0.clipsToBounds = true
//            $0.isUserInteractionEnabled = false
//            completeContainerView.addSubview($0)
//        }
//        completeImageView = UIImageView().also {
//            $0.image = InterfaceImage.complete.image
//            $0.isUserInteractionEnabled = false
//            completeContainerView.addSubview($0)
//        }
//        titleContainerView = UIView().also {
//            $0.layer.cornerRadius = 16.5
//            $0.clipsToBounds = true
//            addSubview($0)
//        }
//        titleLabel = UILabel().also {
//            $0.textColor = .white
////            $0.font = .appFontR(size: 13)
//            $0.numberOfLines = 0
//            titleContainerView.addSubview($0)
//        }
//    }
//
//    func setupConstraints() {
//        completeContainerView.snp.makeConstraints {
//            $0.leading.centerY.equalToSuperview()
//            $0.top.bottom.equalTo(titleContainerView)
//            $0.width.equalTo(42)
//        }
//        priorityView.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(15)
//            $0.centerY.equalToSuperview()
//            $0.trailing.equalToSuperview().offset(-9)
//            $0.width.height.equalTo(18)
//        }
//        completeImageView.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(18)
//            $0.trailing.equalToSuperview().offset(-9)
//            $0.centerY.equalToSuperview().offset(-1.5)
//            $0.width.height.equalTo(15)
//        }
//        titleContainerView.snp.makeConstraints {
//            $0.leading.equalTo(completeContainerView.snp.trailing)
//            $0.top.greaterThanOrEqualToSuperview().offset(5)
//            $0.centerY.equalToSuperview()
//            $0.bottom.greaterThanOrEqualToSuperview().offset(5)
//            $0.trailing.lessThanOrEqualToSuperview().offset(-40)
//        }
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(8)
//            $0.bottom.equalToSuperview().offset(-8)
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalToSuperview().offset(-16)
//        }
//    }
//
//    func configure(_ todo: Todo, indexPath: IndexPath) {
//        self.todo = todo
//        titleLabel.text = todo.title
//        update()
//    }
//
//    func update() {
//        guard let todo = self.todo else { return }
//        if todo.isCompleted == true {
//            completeImageView.isHidden = false
//            priorityView.backgroundColor = .backgroundColor2
//            priorityView.layer.borderColor = UIColor.backgroundColor2.cgColor
//            titleContainerView.backgroundColor = .todoBackground2
//        } else {
//            completeImageView.isHidden = true
//            priorityView.backgroundColor = .clear
//            priorityView.layer.borderColor = todo.priority?.backgroundColor().cgColor
//            priorityView.layer.borderWidth = 2.5
//            titleContainerView.backgroundColor = .todoBackground1
//        }
//    }
//
//    @objc func didTappedComplete() {
//        guard let completed = self.todo?.isCompleted else { return }
//
//        self.todo?.isCompleted = !completed
//        update()
////        presenter?.didChangedComplete(indexPath: indexPath, completed: !completed)
//    }
//}

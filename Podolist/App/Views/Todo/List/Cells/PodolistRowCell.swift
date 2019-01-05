//
//  PodolistRowCell.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

import Scope

class PodolistRowCell: UITableViewCell {

    weak var presenter: PodolistPresenterProtocol?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var completeImage: UIImageView!
    @IBOutlet weak var completeView: UIView!
    var completeContainerButton: UIButton!

    var deleteButton: UIButton!
    var deleteImageView: UIImageView!

    var podo: Podo?
    var indexPath: IndexPath?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deleteButton = UIButton()
//        deleteButton.frame.size = CGSize(width: 14, height: 14)

        deleteButton.backgroundColor = .appColor1
        addSubview(deleteButton)

        deleteImageView = UIImageView()

        deleteImageView.backgroundColor = .red
        deleteButton.addSubview(deleteImageView)
    }

    func setupSubviews() {
        titleLabel = UILabel().also {
            $0.textColor = .white
            $0.font = .appFontR(size: 12)
            addSubview($0)
        }
        roundView = UIView().also {
            $0.layer.cornerRadius = 17.25
            $0.clipsToBounds = true
            addSubview($0)
        }
        priorityView = UIView().also {
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = false
            addSubview($0)
        }
        completeContainerButton = UIButton().also {
            $0.addTarget(self, action: #selector(didTappedComplete), for: .touchUpInside)
            addSubview($0)
        }
        completeImage = UIImageView().also {
            $0.image = InterfaceImage.complete.normalImage
            $0.isUserInteractionEnabled = false
            completeContainerButton.addSubview($0)
        }
    }

    func setupConstraints() {

    }

    func configureWith(_ podo: Podo, indexPath: IndexPath) {
        self.podo = podo
        self.indexPath = indexPath
        titleLabel.text = podo.title
        titleLabel.textColor = .white
        titleLabel.font = .appFontR(size: 12)
        roundView.layer.cornerRadius = 17.25
        roundView.clipsToBounds = true
        priorityView.layer.cornerRadius = priorityView.bounds.width/2
        priorityView.clipsToBounds = true
        priorityView.isUserInteractionEnabled = false
        completeImage.image = InterfaceImage.complete.normalImage
        completeImage.isUserInteractionEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedComplete))
        completeView.addGestureRecognizer(tap)
        deleteButton.addTarget(self, action: #selector(didTappedDelete), for: .touchUpInside)
        update()
    }

    func update() {
        guard let podo = self.podo else { return }
        if podo.isCompleted {
            completeImage.isHidden = false
            roundView.backgroundColor = .todoBackground2
            priorityView.backgroundColor = .backgroundColor2
            priorityView.layer.borderColor = UIColor.backgroundColor2.cgColor
        } else {
            completeImage.isHidden = true
            roundView.backgroundColor = .todoBackground1
            priorityView.backgroundColor = .white
            priorityView.layer.borderColor = podo.priority.backgroundColor().cgColor
            priorityView.layer.borderWidth = 1.5
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        deleteButton.frame = CGRect(x: self.bounds.maxX, y: 10, width: 30, height: 30)
        deleteButton.layer.cornerRadius = deleteButton.frame.width/2
        deleteButton.clipsToBounds = true
        let y = (self.bounds.height - self.deleteButton.frame.height) / 2
        deleteButton.frame.origin.y = y
        deleteButton.setImage(UIImage(named: "ic_delete"), for: .normal)
        deleteButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        deleteImageView.frame = CGRect(x: self.bounds.maxX, y: 10, width: 12, height: 12)
//        deleteImageView.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
//        deleteImageView.image = UIImage(named: "ic_delete")
    }

    @objc func didTappedComplete() {
        guard let podo = self.podo, let indexPath = self.indexPath else { return }
        podo.isCompleted.toggle()
        update()
        presenter?.didChangedComplete(indexPath: indexPath, completed: podo.isCompleted)
    }

    @objc func didTappedDelete() {
        guard let indexPath = self.indexPath else { return }
        presenter?.didTappedDelete(indexPath: indexPath)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            if !self.isSelected {
                UIView.animate(withDuration: 0.2) {
                    self.deleteButton.frame.origin.x = self.bounds.maxX - 40
                    self.deleteImageView.frame.origin.x = self.bounds.maxX - 40
                    super.setSelected(selected, animated: animated)
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.deleteButton.frame.origin.x = self.bounds.maxX
                    self.deleteImageView.frame.origin.x = self.bounds.maxX
                    super.setSelected(!selected, animated: animated)
                }
            }

        } else {
            UIView.animate(withDuration: 0.2) {
                self.deleteButton.frame.origin.x = self.bounds.maxX
                self.deleteImageView.frame.origin.x = self.bounds.maxX
                super.setSelected(selected, animated: animated)
            }
        }
    }
}

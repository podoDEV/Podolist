
import UIKit
import Core
import SnapKit

class TodolistSectionCell: UITableViewHeaderFooterView {

  // MARK: - Constants
  
  private struct Metric {
    static let titleLeading = 18.f
    static let titleTopBottom = 8.f
    static let titleHeight = 16.f
    static let caretWidth = 34.f
    static let caretImageWidth = 9.f
    static let caretImageHeight = 5.f
  }
  
  // MARK: - Subviews
  
  private var titleLabel: UILabel!
  private var caretButton: UIButton!
  private var caretImageView: UIImageView!

  // MARK: - Properties
  
  weak var presenter: TodolistPresenter?
  private var editable: Bool?
  private var visible: Bool?
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupSubviews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupSubviews() {
    contentView.backgroundColor = .white
    titleLabel = UILabel().also {
      $0.font = .preferredFont(type: .notoSansBold, size: 13)
      contentView.addSubview($0)
    }
    caretButton = UIButton().also {
      $0.addTarget(self, action: #selector(didTappedCaret), for: .touchUpInside)
      contentView.addSubview($0)
    }
    caretImageView = UIImageView().also {
      $0.isUserInteractionEnabled = false
      self.caretButton.addSubview($0)
    }
  }
  
  func setupConstraints() {
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.titleLeading)
      $0.top.equalToSuperview().offset(Metric.titleTopBottom)
      $0.bottom.equalToSuperview().offset(-Metric.titleTopBottom)
      $0.height.equalTo(Metric.titleHeight)
    }
    caretButton.snp.makeConstraints {
      $0.top.bottom.trailing.equalToSuperview()
      $0.width.equalTo(Metric.caretWidth)
    }
    caretImageView.snp.makeConstraints {
      $0.width.equalTo(Metric.caretImageWidth)
      $0.height.equalTo(Metric.caretImageHeight)
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  func configure(_ sectionItem: TodoSection) {
    titleLabel.text = sectionItem.title
    titleLabel.textColor = sectionItem.color
    editable = sectionItem.editable
    visible = sectionItem.visible

    if sectionItem.editable {
      caretImageView.isHidden = false
      caretButton.isHidden = false
      if sectionItem.visible {
        caretImageView.image = "ic_caretDelayedClose".uiImage
      } else {
        caretImageView.image = "ic_caretDelayedOpen".uiImage
      }
    } else {
      caretImageView.isHidden = true
      caretButton.isHidden = true
    }

  }
}

private extension TodolistSectionCell {
  @objc func didTappedCaret() {
    guard var visible = self.visible else { return }
    visible.toggle()
    presenter?.didChangedShowDelayed(show: visible)
  }
}

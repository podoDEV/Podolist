
import UIKit
import Scope
import SnapKit

final class LoginButton: UIButton {

  // MARK: - Constants

  private struct Metric {
    static let height = 28.f
    static let textLeading = 6.f
  }

  // MARK: - Subviews

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
    containerView = UIView().also {
      $0.isUserInteractionEnabled = false
      $0.backgroundColor = .clear
      addSubview($0)
    }
    iconImage = UIImageView().also {
      containerView.addSubview($0)
    }
    textLabel = UILabel().also {
      $0.font = .preferredFont(type: .notoSansRegular, size: 14)
      $0.textColor = .black
      $0.sizeToFit()
      containerView.addSubview($0)
    }
  }

  func setupConstraints() {
    containerView.snp.makeConstraints {
      $0.height.equalTo(iconImage.snp.height)
      $0.center.equalTo(snp.center)
    }
    iconImage.snp.makeConstraints {
      $0.leading.equalTo(containerView.snp.leading)
      $0.height.width.equalTo(Metric.height)
    }
    textLabel.snp.makeConstraints {
      $0.leading.equalTo(iconImage.snp.trailing).offset(Metric.textLeading)
      $0.trailing.equalTo(containerView.snp.trailing)
      $0.height.equalTo(Metric.height)
    }
  }

  func configure(image: UIImage?, title: String, color: UIColor) {
    iconImage.image = image
    textLabel.text = title
    backgroundColor = color
  }
}


import UIKit
import Scope
import SnapKit

final class LoginButton: UIButton {

  private struct Const {
    static let height = 20.f
    static let spacing = 4.f
  }

  // MARK: - Subviews

  private var containerView: UIStackView!
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
    containerView = UIStackView().also {
      $0.axis = .horizontal
      $0.alignment = .center
      $0.distribution = .fill
      $0.backgroundColor = .clear
      $0.spacing = Const.spacing
      addSubview($0)
    }
    iconImage = UIImageView().also {
      containerView.addArrangedSubview($0)
    }
    textLabel = UILabel().also {
      $0.font = .preferredFont(type: .notoSansMedium, size: 14)
      $0.textColor = .init(hex: 0x000000)
      $0.numberOfLines = 1
      containerView.addArrangedSubview($0)
    }
  }

  func setupConstraints() {
    containerView.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    iconImage.snp.makeConstraints {
      $0.width.height.equalTo(Const.height)
    }
    textLabel.snp.makeConstraints {
      $0.height.equalTo(Const.height)
    }
  }

  func configure(image: UIImage?, title: String, color: UIColor) {
    iconImage.image = image
    textLabel.text = title
    backgroundColor = color
  }
}

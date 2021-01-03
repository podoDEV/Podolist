
import UIKit
import Core
import Resources
import Scope
import SnapKit

final class SettingCell: BaseTableViewCell {

  // MARK: - Constants

  private struct Metric {
    static let thumbnailLeading = 24.f
    static let thumbnailTopBottom = 18.f
    static let thumbnailWH = 18.f
    static let titleLeading = 22.f
    static let titleHeight = 16.f
    static let titleWidth = 150.f
  }

  // MARK: - Subviews

  var thumbnailView: UIImageView!
  var titleLabel: UILabel!

  override func setupSubviews() {
    selectionStyle = .none
    thumbnailView = UIImageView().also {
      contentView.addSubview($0)
    }
    titleLabel = UILabel().also {
      $0.font = .preferredFont(type: .notoSansLight, size: 14)
      $0.textColor = .black
      $0.sizeToFit()
      contentView.addSubview($0)
    }
  }

  override func setupConstraints() {
    thumbnailView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.thumbnailLeading)
      $0.top.equalToSuperview().offset(Metric.thumbnailTopBottom)
      $0.bottom.equalToSuperview().offset(-Metric.thumbnailTopBottom)
      $0.width.height.equalTo(Metric.thumbnailWH)
    }
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(thumbnailView.snp.trailing).offset(Metric.titleLeading)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(Metric.titleHeight)
      $0.width.equalTo(Metric.titleWidth)
    }
  }
}

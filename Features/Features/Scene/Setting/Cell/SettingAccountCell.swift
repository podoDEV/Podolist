
import UIKit
import Core
import Resources
import Scope
import SnapKit

final class SettingAccountCell: BaseTableViewCell {

  // MARK: - Subviews

  private var thumbnailView: UIImageView!
  private var nameLabel: UILabel!
  //    private var emailLabel: UILabel!

  override func setupSubviews() {
    selectionStyle = .none
    thumbnailView = UIImageView().also {
      $0.clipsToBounds = true
      $0.image = "ic_profile".uiImage
      contentView.addSubview($0)
    }
    nameLabel = UILabel().also {
      $0.font = .preferredFont(type: .notoSansLight, size: 18)
      $0.textColor = .black
      $0.sizeToFit()
      contentView.addSubview($0)
    }
    //        emailLabel = UILabel().also {
    //            $0.font = .appFontL(size: 13)
    //            $0.textColor = .black
    //            $0.sizeToFit()
    //            contentView.addSubview($0)
    //        }
  }

  override func setupConstraints() {
    thumbnailView.translatesAutoresizingMaskIntoConstraints = false
    thumbnailView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
    thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
    thumbnailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    thumbnailView.widthAnchor.constraint(equalToConstant: 54).isActive = true
    thumbnailView.heightAnchor.constraint(equalTo: thumbnailView.widthAnchor).isActive = true
    thumbnailView.layer.cornerRadius = 27

    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 32).isActive = true
    nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
    nameLabel.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
  }

//  func configure(with item: SettingRowProtocol) {
//    if let item = item as? SettingAccountRowProtocol {
//      ImageLoader.image(for: item.imageUrl) { [weak self] image in
//        self?.thumbnailView.image = image ?? InterfaceImage.profile.image
//      }
//      nameLabel.text = item.name
//    }
//  }
}

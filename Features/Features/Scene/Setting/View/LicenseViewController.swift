
import UIKit
import Core
import Scope
import SnapKit

class LicenseViewController: BaseViewController {
  private var licenseView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    analytics.log(.license_view)
  }
  
  override func setupSubviews() {
    view.backgroundColor = .white
    title = "setting.license".localized
    licenseView = UITextView().also {
      $0.text = String(urlOfResourceFile: "license.txt")
      $0.font = .preferredFont(type: .notoSansLight, size: 14)
      $0.contentOffset = .zero
      view.addSubview($0)
    }
  }

  override func setupConstraints() {
    licenseView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

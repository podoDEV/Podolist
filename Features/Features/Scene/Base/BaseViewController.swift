
import UIKit

public class BaseViewController: UIViewController {
  var safeAreaInset: UIEdgeInsets = .zero {
    didSet {
      setupConstraints()
    }
  }

  public override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    setupNavigationBar()
    setupConstraints()
  }

  public func setupSubviews() {}
  public func setupConstraints() {}
  public func setupNavigationBar() {
    navigationController?.navigationBar.barTintColor = .appColor1
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationItem.largeTitleDisplayMode = .automatic
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
  }
}

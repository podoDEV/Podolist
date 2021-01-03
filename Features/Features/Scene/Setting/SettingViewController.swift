
import UIKit
import MessageUI
import Core
import Scope
import SnapKit

protocol SettingViewProtocol: AnyObject {
  func reloadData()
  func showMailComposeVC(recipients: [String], subject: String, message: String)
  func showAboutVC()
  func showLicenseVC()
  func showLoginVC()
  func showErrorView(title: String, message: String)
  func showLogoutAlert(actionTitle: String)
}

public class SettingViewController: BaseViewController {

  // MARK: - Subviews

  private var tableView: UITableView!

  // MARK: - Properties

  var presenter: SettingPresenter

  init(presenter: SettingPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    analytics.log(.settings_view)
    presenter.viewDidLoad()
  }

  public override func setupSubviews() {
    title = "setting".localized
    tableView = UITableView(frame: .zero, style: .grouped).also {
      $0.estimatedRowHeight = 300
      $0.separatorStyle = .none
      $0.delegate = self
      $0.dataSource = self
      $0.backgroundColor = .white
      $0.isScrollEnabled = false
      $0.tableFooterView = UIView()
      $0.register(cell: SettingCell.self)
      $0.register(cell: SettingAccountCell.self)
      view.addSubview($0)
    }
  }

  public override func setupConstraints() {
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension SettingViewController: SettingViewProtocol {
  func reloadData() {
    tableView.reloadData()
  }

  func showMailComposeVC(recipients: [String], subject: String, message: String) {
    if MFMailComposeViewController.canSendMail() {
      let mailComposer = MFMailComposeViewController()
      mailComposer.mailComposeDelegate = self
      mailComposer.setToRecipients(recipients)
      mailComposer.setSubject(subject)
      mailComposer.setMessageBody(message, isHTML: false)
      mailComposer.modalPresentationStyle = .currentContext
      present(mailComposer, animated: true)
    }
  }

  func showAboutVC() {
    navigationController?.pushViewController(AboutViewController(), animated: true)
  }

  func showLicenseVC() {
    navigationController?.pushViewController(LicenseViewController(), animated: true)
  }

  func showLoginVC() {

  }

  func showErrorView(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "common.ok".localized, style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }

  func showLogoutAlert(actionTitle: String) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let userAction = UIAlertAction(title: actionTitle, style: .destructive) { [weak self] _ in
      self?.presenter.logout()
    }
    let cancelAction = UIAlertAction(title: "common.cancel".localized, style: .cancel, handler: nil)
    alertController.addAction(userAction)
    alertController.addAction(cancelAction)
    present(alertController , animated: true)
  }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
  public func mailComposeController(
    _ controller: MFMailComposeViewController,
    didFinishWith result: MFMailComposeResult,
    error: Error?
  ) {
    navigationController?.popViewController(animated: true)
  }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectRow(at: indexPath)
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfRows(in: section)
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    presenter.configureCell(tableView, cellForRowAt: indexPath)
  }
}

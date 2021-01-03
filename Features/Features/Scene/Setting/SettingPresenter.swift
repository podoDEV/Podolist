
import MessageUI
import Core
import Services
import KakaoSDKCommon
import KakaoSDKAuth

final class SettingPresenter {
  private let authService: AuthServiceType
  private var memberService: MemberServiceType
  weak var view: SettingViewProtocol?

  var sections: [SettingSectionModel] = []

  init(authService: AuthServiceType, memberService: MemberServiceType) {
    self.authService = authService
    self.memberService = memberService
  }
}

extension SettingPresenter {
  func logout() {
    authService.logout()
    analytics.log(.logout)
  }

  func viewDidLoad() {
    sections = [
      .info(items: [
        .about(SettingRow(type: .about, title: "setting.about".localized)),
        .license(SettingRow(type: .license, title: "setting.license".localized)),
        .feedback(SettingRow(type: .feedback, title: "setting.feedback".localized)),
        .logout(SettingRow(type: .logout, title: "setting.logout".localized))
      ])
    ]
    view?.reloadData()
  }

  func numberOfRows(in section: Int) -> Int {
    sections[section].items.count
  }

  func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = sections[indexPath.section].items[indexPath.row]
    switch item {
    case .account:
      let cell = tableView.dequeue(SettingAccountCell.self)!
      return cell
    case .about:
      let cell = tableView.dequeue(SettingCell.self)!
      cell.titleLabel.text = "setting.about".localized
      cell.thumbnailView.image = "ic_about".uiImage
      return cell
    case .license:
      let cell = tableView.dequeue(SettingCell.self)!
      cell.titleLabel.text = "setting.license".localized
      cell.thumbnailView.image = "ic_license".uiImage
      return cell
    case .feedback:
      let cell = tableView.dequeue(SettingCell.self)!
      cell.titleLabel.text = "setting.feedback".localized
      cell.thumbnailView.image = "ic_sendFeedback".uiImage
      return cell
    case .logout:
      let cell = tableView.dequeue(SettingCell.self)!
      cell.titleLabel.text = "setting.logout".localized
      cell.thumbnailView.image = "ic_logout".uiImage
      return cell
    }
  }

  func didSelectRow(at indexPath: IndexPath) {
    let item = sections[indexPath.section].items[indexPath.row]
    switch item {
    case .account:
      break
    case .about:
      view?.showAboutVC()
    case .license:
      view?.showLicenseVC()
    case .feedback:
      if MFMailComposeViewController.canSendMail() {
        view?.showMailComposeVC(
          recipients: ["podo.devops@gmail.com", "heebuma@gmail.com"],
          subject: "[Feedback] ",
          message: getInfo()
        )
      } else {
        view?.showErrorView(
          title: "error.email.title".localized,
          message: "error.email.body".localized
        )
      }
    case .logout:
      view?.showLogoutAlert(actionTitle: "setting.logout".localized)
    }
  }

  func getInfo() -> String {
    return """
        \n\n\n\n
        ---------------------------------
        My App: \("common.podolist".localized)
        My Version: \(AppUtils.AppVersion)(\(AppUtils.AppBuildVersion))
        My iOS: \(AppUtils.iOSVersion)
        ---------------------------------
        """
  }
}

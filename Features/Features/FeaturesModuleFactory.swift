
import Services

public class FeaturesModuleFactory {
  static var config: FeaturesConfiguration.Type?
  private static var _config: FeaturesConfiguration.Type {
    guard let config = config else {
      preconditionFailure("Please configure FeaturesModule before access")
    }
    return config
  }

  public static var loginVC: LoginViewController {
    let presenter = LoginPresenter(authService: ServicesModuleFactory.authService)
    let vc = LoginViewController(presenter: presenter)
    presenter.view = vc
    return vc
  }

  public static var todoVC: TodolistViewController {
//    let presenter = LoginPresenter(authService: ServicesModuleFactory.authService)
//    let presenter = TodolistPresenter
//    let vc = TodolistViewController(presenter: presenter)
//    presenter.view = vc
    let vc = TodolistViewController()
    return vc
  }

  public static var settingVC: SettingViewController {
    let presenter = SettingPresenter(
      authService: ServicesModuleFactory.authService,
      memberService: ServicesModuleFactory.memberService
    )
    let vc = SettingViewController(presenter: presenter)
    presenter.view = vc
    return vc
  }
}

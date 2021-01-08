
import UIKit
import Core
import Services
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginPresenter {
  private let authService: AuthServiceType
  weak var view: LoginViewProtocol?

  init(authService: AuthServiceType) {
    self.authService = authService
  }
  
  func didTapAppleLogin(id: String) {
    let provider = AuthProvider.apple(id)
    authService.authorize(provider) { [weak self] result in
      switch result {
      case .success:
        analytics.log(.login(provider.rawValue()))
        self?.view?.completeLogin()
      case .failure:
        break
      }
    }
  }

  func didTapKakaoLogin() {
    getkakaoSession { [weak self] id in
      guard let id = id else { return }
      let provider = AuthProvider.kakao(id)
      self?.authService.authorize(provider) { [weak self] result in
        switch result {
        case .success:
          analytics.log(.login(provider.rawValue()))
          self?.view?.completeLogin()
        case .failure:
          break
        }
      }

    }
  }

  func didTapAnonymousLogin() {
    let uuid = getUUID()
    let provider = AuthProvider.anonymous(uuid)
    authService.authorize(provider) { [weak self] result in
      switch result {
      case .success:
        analytics.log(.login(provider.rawValue()))
        self?.view?.completeLogin()
      case .failure:
        break
      }
    }
  }
}

private extension LoginPresenter {
  func getkakaoSession(_ completion: @escaping (String?) -> Void) {
    if AuthApi.isKakaoTalkLoginAvailable() {
      AuthApi.shared.loginWithKakaoTalk { (_, error) in
        if let error = error {
          log.debug(error)
        } else {
          UserApi.shared.me() {(user, error) in
            if let error = error {
              print(error)
            }
            else {
              completion(user?.id.toString)
            }
          }
        }
      }
    }
  }

  func getUUID() -> String {
    return UIDevice.current.identifierForVendor!.uuidString
  }
}

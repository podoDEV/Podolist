
import UIKit
import Core
import Services
import KakaoSDKCommon
import KakaoSDKAuth

class LoginPresenter {
  private let authService: AuthServiceType
  weak var view: LoginViewProtocol?

  init(authService: AuthServiceType) {
    self.authService = authService
  }

  func didTapKakaoLogin() {
    getkakaoSession { [weak self] token in
      guard let token = token else { return }
      let provider = AuthProvider.kakao(token)
      self?.authService.authorize(provider) { [weak self] result in
        switch result {
        case .success:
          analytics.log(.login(provider.rawValue()))
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
      //            self?.presenter?.completeLogin()
      case .failure:
        break
      }
    }
  }

  func completeLogin() {
//    wireframe.navigate(to: .todo)
  }
}

private extension LoginPresenter {
  func getkakaoSession(_ completion: @escaping (String?) -> Void) {
    if AuthApi.isKakaoTalkLoginAvailable() {
      AuthApi.shared.loginWithKakaoTalk { (oauthToken, error) in
        if let error = error {
          log.debug(error)
        } else {
          completion(oauthToken?.accessToken)
        }
      }
    }
  }

  func getUUID() -> String {
    return UIDevice.current.identifierForVendor!.uuidString
  }
}

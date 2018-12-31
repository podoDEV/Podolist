//
//  LoginViewController.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

protocol LoginViewProtocol: class {
    // Presenter -> View
    func showLogin()
}

class LoginViewController: BaseViewController {

    // MARK: - Properties

    var presenter: LoginPresenterProtocol!

    // MARK: - Views

    private lazy var launchView: UIView = {
        let view = Bundle.main.loadNibNamed("Launch", owner: self, options: nil)?.first as! UIView
        return view
    }()

    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.image = InterfaceImage.logo.normalImage
        return view
    }()

    private lazy var logoView2: UIImageView = {
        let view = UIImageView()
        view.image = InterfaceImage.logo2.normalImage
        return view
    }()

    private lazy var kakaoLoginButton: LoginButton = {
        let view = LoginButton()
        view.configure(image: InterfaceImage.kakaologin.normalImage,
                       title: InterfaceString.Login.Kakao,
                       color: .kakaoLogin)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    private lazy var anonymousLoginButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.titleLabel?.font = .appFontR(size: 14)
        view.setTitle(InterfaceString.Login.Anonymous, for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func setupSubviews() {
        super.setupSubviews()

        kakaoLoginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
        anonymousLoginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)

        [launchView, logoView, logoView2, kakaoLoginButton, anonymousLoginButton].forEach(view.addSubview)
        view.bringSubview(toFront: launchView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        launchView.snp.makeConstraints {
            $0.size.equalToSuperview()
            $0.center.equalToSuperview()
        }

        logoView.snp.makeConstraints {
            $0.width.equalTo(86)
            $0.height.equalTo(94)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }

        logoView2.snp.makeConstraints {
            $0.width.equalTo(119)
            $0.height.equalTo(31)
            $0.top.equalTo(logoView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }

        kakaoLoginButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(60)
            $0.trailing.equalTo(view.snp.trailing).offset(-60)
            $0.height.equalTo(40)
            $0.width.greaterThanOrEqualTo(240)
        }

        anonymousLoginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().offset(-60)
            $0.height.equalTo(40)
            $0.top.equalTo(kakaoLoginButton.snp.bottom).offset(40)
            $0.bottom.equalToSuperview().offset(-90)
        }
    }

    // MARK: - Target Action

    @objc func didTapLogin(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        switch button {
        case kakaoLoginButton:
            presenter.didTapKakaoLogin()
        case anonymousLoginButton:
            presenter.didTapAnonymousLogin()
        default:
            break
        }
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {

    func showLogin() {
        launchView.removeFromSuperview()
        KOSession.shared().logoutAndClose { _, _ in }
    }
}

//
//  LoginViewController.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Core
import Scope
import SnapKit

protocol LoginViewProtocol: AnyObject {
    // MARK: - Presenter -> View
}

class LoginViewController: BaseViewController, LoginViewProtocol {

    // MARK: - Constants

    private struct Metric {
        static let logo1Width = 86.f
        static let logo1Height = 94.f
        static let logo2Width = 120.f
        static let logo2Height = 31.f
        static let stackLeadingTrailing = 60.f
        static let stackBottom = 60.f
        static let stackSpacing = 40.f
        static let buttonHeight = 40.f
    }

    // MARK: - Subviews

    private var logoView: UIImageView!
    private var logoView2: UIImageView!
    private var providerStackView: UIStackView!
    private var kakaoLoginButton: LoginButton!
    private var anonymousLoginButton: UIButton!

    // MARK: - Properties

    var presenter: LoginPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.log(.login_view)
    }

    override func setupSubviews() {
        logoView = UIImageView().also {
            $0.image = InterfaceImage.logo.image
            view.addSubview($0)
        }
        logoView2 = UIImageView().also {
            $0.image = InterfaceImage.logo2.image
            view.addSubview($0)
        }
        providerStackView = UIStackView().also {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = Metric.stackSpacing
            view.addSubview($0)
        }
        kakaoLoginButton = LoginButton().also {
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
            $0.configure(
                image: InterfaceImage.kakaologin.image,
                title: "login.kakao".localized,
                color: .kakaoLogin
            )
            providerStackView.addArrangedSubview($0)
        }
        anonymousLoginButton = UIButton().also {
            $0.backgroundColor = .clear
            $0.titleLabel?.font = .appFontR(size: 14)
            $0.setTitle("login.anonymous".localized, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
            providerStackView.addArrangedSubview($0)
        }
    }

    override func setupConstraints() {
        logoView.snp.makeConstraints {
            $0.width.equalTo(Metric.logo1Width)
            $0.height.equalTo(Metric.logo1Height)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }
        logoView2.snp.makeConstraints {
            $0.width.equalTo(Metric.logo2Width)
            $0.height.equalTo(Metric.logo2Height)
            $0.top.equalTo(logoView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        providerStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Metric.stackLeadingTrailing)
            $0.trailing.equalToSuperview().offset(-Metric.stackLeadingTrailing)
            $0.bottom.equalToSuperview().offset(-Metric.stackBottom)
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(Metric.buttonHeight)
        }
        anonymousLoginButton.snp.makeConstraints {
            $0.height.equalTo(Metric.buttonHeight)
        }
    }

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

//
//  LoginView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - UIViewController
class LoginView: UIViewController {
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        presenter?.viewDidLoad()
        showLoading()
    }
}

// MARK: - LoginViewProtocol
extension LoginView: LoginViewProtocol {
    
    func showError() {
        hideLoading()
    }
}

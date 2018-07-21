//
//  LoginViewController.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var formView: UIView!
    
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var emailTextField: FormTextField!
    @IBOutlet private weak var passwordTextField: FormTextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var lostPasswordLabel: UILabel!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        applyLocalization()
        applyStyling()
        addKeyboardObservers()
    }
    
    // MARK: - Keyboard observers
    
    override func keyboardWillShow(keyboardHeight: CGFloat, duration: Double) {
        scrollView.contentInset.bottom = keyboardHeight
    }
    
    override func keyboardWillHide(keyboardHeight: CGFloat, duration: Double) {
        scrollView.contentInset.bottom = 0
    }
}

// MARK: Actions

private extension LoginViewController {
    
    @IBAction func loginButtonTapped() {
        let homeViewController: HomeViewController = UIViewController.instantiate()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

// MARK: Private Helpers

private extension LoginViewController {
    
    func configureViews() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        scrollView.bounces = false
    }
    
    func applyLocalization() {
        // TODO: Get texts from localization string file
        loginLabel.text = "Giriş Yapın"
        loginButton.setAttributedTitle(NSAttributedString(text: "GİRİŞ YAP", font: .body5, color: .white),
                                       for: .normal)
        registerButton.setAttributedTitle(NSAttributedString(text: "Kayıt Ol", font: .body1, color: .white),
                                          for: .normal)
        emailTextField.placeholder = "E-posta"
        passwordTextField.placeholder = "Şifre"
    }
    
    func applyStyling() {
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = UIConstant.cornerRadius
        formView.layer.cornerRadius = UIConstant.cornerRadius
        formView.clipsToBounds = true
        loginLabel.applyStyle(font: .heading1)
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return view.endEditing(true)
    }
}

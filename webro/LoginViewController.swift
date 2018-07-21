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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Keyboard observers
    
    override func keyboardWillShow(keyboardHeight: CGFloat, duration: Double) {
        scrollView.contentInset.bottom = keyboardHeight
    }
    
    override func keyboardWillHide(keyboardHeight: CGFloat, duration: Double) {
        scrollView.contentInset.bottom = 0
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
        loginButton.setAttributedTitle(NSAttributedString(text: "GİRİŞ YAP", font: .b5, color: .white),
                                       for: .normal)
        registerButton.setAttributedTitle(NSAttributedString(text: "Kayıt Ol", font: .b1, color: .white),
                                          for: .normal)
        emailTextField.placeholder = "E-posta"
        passwordTextField.placeholder = "Şifre"
    }
    
    func applyStyling() {
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = UIConstant.cornerRadius
        formView.layer.cornerRadius = UIConstant.cornerRadius
        formView.clipsToBounds = true
        loginLabel.applyStyle(font: .h1)
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return view.endEditing(true)
    }
}

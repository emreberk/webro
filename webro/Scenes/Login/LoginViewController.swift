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
    
    // MARK: - Network
    
    private func login() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showLoading(false)
            return
        }
        
        Service.main.request(.login(email: email, password: password)) { [weak self] (t: User?, error) in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.showLoading(false)
            
            guard let user = t else {
                if let errorMessage = error?.message {
                    strongSelf.showMessage(errorMessage)
                }
                return
            }
            
            User.current = user
            let homeViewController: HomeViewController = UIViewController.instantiate()
            strongSelf.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
}

// MARK: Actions

private extension LoginViewController {
    
    @IBAction func loginButtonTapped() {
        showLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.login()
        }
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
        lostPasswordLabel.attributedText = lostPasswordText()
    }
    
    func applyStyling() {
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = UIConstant.cornerRadius
        formView.layer.cornerRadius = UIConstant.cornerRadius
        formView.clipsToBounds = true
        loginLabel.applyStyle(font: .heading1)
    }
    
    // FIXME: Make it dynamic
    func lostPasswordText() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "Spiderman yardım et, Şifremi unuttum!", attributes: [
            .font: UIFont(name: "Catamaran-Regular", size: 14.0)!,
            .foregroundColor: UIColor(red: 15.0 / 255.0, green: 5.0 / 255.0, blue: 23.0 / 255.0, alpha: 0.6),
            .kern: 0.3
            ])
        attributedString.addAttributes([
            .font: UIFont(name: "Catamaran-Medium", size: 14.0)!,
            .foregroundColor: UIColor.black
            ], range: NSRange(location: 21, length: 16))
        return attributedString
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return view.endEditing(true)
    }
}

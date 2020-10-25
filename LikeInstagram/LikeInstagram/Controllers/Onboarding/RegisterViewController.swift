//
//  RegisterViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties

    private let usernameField: UITextField = {
        let field: UITextField = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()

    private let emailField: UITextField = {
        let field: UITextField = UITextField()
        field.placeholder = "Email Address"
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()

    private let passwordField: UITextField = {
        let field: UITextField = UITextField()
        field.placeholder = "PassWord"
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = #colorLiteral(red: 0.06168776006, green: 0.2999084294, blue: 0.5110028386, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        addSubViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        usernameField.frame = CGRect(x: 20,
            y: view.safeAreaInsets.top + 10,
            width: view.width - 40,
            height: 52)

        emailField.frame = CGRect(x: 20,
            y: usernameField.bottom + 10,
            width: view.width - 40,
            height: 52)

        passwordField.frame = CGRect(x: 20,
            y: emailField.bottom + 10,
            width: view.width - 40,
            height: 52)

        registerButton.frame = CGRect(x: 20,
            y: passwordField.bottom + 10,
            width: view.width - 40,
            height: 52)
    }

    private func addSubViews() {
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(registerButton)
    }

    @objc private func didTapRegister() {
        self.view.endEditing(true)

        guard let email = emailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8,
            let username = usernameField.text, !username.isEmpty else {
                return
        }
        // Registration logic
        AuthManager.shared.registerNewUser(username: username, email: email, passwored: password) { [weak self]registered in
            guard let self = self else { return }
            if registered {
                // success
                self.dismiss(animated: true, completion: nil)
            } else {
                // fail
                self.showAlert(title: "Register Error", message: "회원가입 중 에러가 발생했습니다.")
            }
        }

    }

}

extension RegisterViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapRegister()
        }

        return true
    }
}

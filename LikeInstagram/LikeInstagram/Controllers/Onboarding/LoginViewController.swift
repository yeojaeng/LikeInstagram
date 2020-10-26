//
//  LoginViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private let usernameEmailField: UITextField = {
        let field: UITextField = UITextField()
        field.placeholder = "Username or Email"
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
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .done
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

    private let loginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = #colorLiteral(red: 0.2695983648, green: 0.541346848, blue: 0.9669736028, alpha: 1)
        return button
    }()

    private let termsButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Terms of Services", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()

    private let privacyButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()

    private let createAccountButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private let headerView: UIView = {
        let header: UIView = UIView()
        header.clipsToBounds = true
        let backgroundImageView: UIImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubViews()
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                                      action: #selector(didTapCreateAccountButton),
                                      for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        privacyButton.addTarget(self,
                                action: #selector(didTapPrivacyButton),
                                for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        // set frame UI Components
        super.viewDidLayoutSubviews()

        headerView.frame = CGRect(x: view.left,
                                  y: view.top,
                                  width: view.width,
                                  height: view.height / 3.0)

        usernameEmailField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 40,
                                          width: view.width - 50,
                                          height: 52.0)

        passwordField.frame = CGRect(x: 25,
                                     y: usernameEmailField.bottom + 10,
                                     width: view.width - 50,
                                     height: 52.0)

        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom + 30,
                                   width: view.width - 50,
                                   height: 52.0)

        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52.0)

        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 100,
                                   width: view.width - 20,
                                   height: 50)

        privacyButton.frame = CGRect(x: 10,
                                     y: view.height - view.safeAreaInsets.bottom - 50,
                                     width: view.width - 20,
                                     height: 50)

        configureHeaderView()
    }

    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }

        guard let backgroundView = headerView.subviews.first else {
            return
        }

        backgroundView.frame = headerView.bounds
        let logoView: UIImageView = UIImageView(image: UIImage(named: "logo"))
        headerView.addSubview(logoView)
        logoView.contentMode = .scaleAspectFit
        logoView.frame = CGRect(x: headerView.width / 4.0,
                                y: view.safeAreaInsets.top,
                                width: headerView.width / 2.0,
                                height: headerView.height - view.safeAreaInsets.top)
    }

    private func addSubViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
    }

    
    /// 로그인 검증 메소드
    @objc private func didTapLoginButton() {
        self.view.endEditing(true)
        var username: String?
        var email: String?

        // ID 가져오기
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty else {
            showAlert(title: "Login Error", message: "ID를 정확히 입력해주세요.")
            return
        }

        // PW 가져오기
        guard let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            showAlert(title: "Login Error", message: "페스워드는 8자 이상으로 입력해주세요.")
            return
        }

        // 유효값 검증
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        } else {
            // username
            username = usernameEmail
        }

        // 로그인 진행
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // error occured
                    self.showAlert(title: "Login Error", message: "로그인 에러 발생")
                }
            }
        }
    }

    // 사용약관 페이지로 이동
    @objc private func didTapTermsButton() {
        guard let url = URL(string: Constants.termsOfServiceURL) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

    // 개인정보처리방침 페이지로 이동
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: Constants.privacyURL) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

    // 회원가입 페이지로 이동
    @objc private func didTapCreateAccountButton() {
        let registerVC = RegisterViewController()
        registerVC.title = "Create Account"
        let navigationVC = UINavigationController(rootViewController: registerVC)
        present(navigationVC, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}

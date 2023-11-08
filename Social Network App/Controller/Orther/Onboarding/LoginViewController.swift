//
//  LoginViewController.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constrain {
        static let cornerRadius: CGFloat = 8
        static let margin: CGFloat = 20
        static let heightTF: CGFloat = 50
    }
    
    private let userNameOfEmailTF: UITextField = {
        let field = UITextField()
        field.placeholder = "Tên tài khoản hoặc mail..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constrain.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Mật khẩu..."
        field.isSecureTextEntry = true
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constrain.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Đăng nhập", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constrain.cornerRadius
        button.backgroundColor = .systemBlue
        return button
    }()
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Điều khoản dịch vụ", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Chính sách bảo mật", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Người dùng mới? Tạo tài khoản nhé", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constrain.cornerRadius
        button.backgroundColor = .lightGray
        return button
    }()
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let background = UIImageView(image: UIImage(named: "background"))
        background.contentMode = .scaleAspectFill
        header.addSubview(background)
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameOfEmailTF.delegate = self
        passwordField.delegate = self
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(userNameOfEmailTF)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        
        loginButton.addTarget(self, action: #selector(didTapLoginBT), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountBT), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsBT), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyBT), for: .touchUpInside)
        
        configureHeaderView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height / 3)
        userNameOfEmailTF.frame = CGRect(x: Constrain.margin,
                                         y: headerView.bottom + Constrain.margin / 2,
                                         width: view.width - Constrain.margin * 2,
                                         height: Constrain.heightTF)
        passwordField.frame = CGRect(x: Constrain.margin,
                                     y: userNameOfEmailTF.bottom + Constrain.margin / 2,
                                     width: view.width - Constrain.margin * 2,
                                     height: Constrain.heightTF)
        loginButton.frame = CGRect(x: Constrain.margin,
                                   y: passwordField.bottom + Constrain.margin / 2,
                                   width: view.width - Constrain.margin * 2,
                                   height: Constrain.heightTF)
        createAccountButton.frame = CGRect(x: Constrain.margin,
                                           y: loginButton.bottom + Constrain.margin / 2,
                                           width: view.width - Constrain.margin * 2,
                                           height: Constrain.heightTF)
        termsButton.frame = CGRect(x: Constrain.margin / 2,
                                   y: view.height - view.safeAreaInsets.bottom - Constrain.heightTF * 2,
                                   width: view.width - Constrain.margin * 2,
                                   height: Constrain.heightTF)
        privacyButton.frame = CGRect(x: Constrain.margin / 2,
                                     y: view.height - view.safeAreaInsets.bottom - Constrain.heightTF,
                                     width: view.width - Constrain.margin * 2,
                                     height: Constrain.heightTF)
    }
    private func configureHeaderView() {
        guard headerView.subviews.count != 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        let imageView = UIImageView(image: UIImage(named: "text"))
        backgroundView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4, y: view.safeAreaInsets.top,
                                 width: headerView.width / 2, height: headerView.height - view.safeAreaInsets.top)

    }
    
    @objc private func didTapLoginBT() {
        passwordField.resignFirstResponder()
        userNameOfEmailTF.resignFirstResponder()
        
        guard let userNameEmail = userNameOfEmailTF.text, !userNameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                return
        }
        var username: String?
        var email: String?
        
        if userNameEmail.contains("@"), userNameEmail.contains(".") {
            email = userNameEmail
        } else {
            username = userNameEmail
        }
        AuthManager.shared.loginUser(userName: username,
                                     email: email,
                                     password: password) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Sai thông tin đăng nhập",
                                                  message: "Hoặc chưa có tài khoản",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Bỏ qua", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc private func didTapTermsBT() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapPrivacyBT() {
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapCreateAccountBT() {
        let vc = RegistrationViewController()
        vc.title = "Tạo tài khoản mới"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameOfEmailTF {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            
        }
        return true
    }
    
}

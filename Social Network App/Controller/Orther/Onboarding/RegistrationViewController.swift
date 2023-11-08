//
//  RegistrationViewController.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constrain {
        static let cornerRadius: CGFloat = 8
        static let margin: CGFloat = 20
        static let heightTF: CGFloat = 50
    }
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Tên tài khoản..."
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
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
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
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Đăng nhập", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constrain.cornerRadius
        button.backgroundColor = .systemGreen
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(didTapRegisterBT), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userNameField.frame = CGRect(x: Constrain.margin,
                                     y: view.safeAreaInsets.top + Constrain.margin / 2,
                                     width: view.width - Constrain.margin * 2,
                                     height: Constrain.heightTF)
        emailField.frame = CGRect(x: Constrain.margin,
                                  y: userNameField.bottom + Constrain.margin / 2,
                                  width: view.width - Constrain.margin * 2,
                                  height: Constrain.heightTF)
        passwordField.frame = CGRect(x: Constrain.margin,
                                     y: emailField.bottom + Constrain.margin / 2,
                                     width: view.width - Constrain.margin * 2,
                                     height: Constrain.heightTF)
        registerButton.frame = CGRect(x: Constrain.margin,
                                      y: passwordField.bottom + Constrain.margin / 2,
                                      width: view.width - Constrain.margin * 2,
                                      height: Constrain.heightTF)
    }
    @objc private func didTapRegisterBT() {
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        
        guard let userName = emailField.text, !userName.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = emailField.text, !password.isEmpty, password.count >= 8 else {
                  return
        }
        AuthManager.shared.registerNewUser(userName: userName, email: email, password: password) { registed in
            DispatchQueue.main.async {
                if registed {
                    
                } else {
                    
                }
            }
        }
    }
}
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            didTapRegisterBT()
        }
        return true
    }
}

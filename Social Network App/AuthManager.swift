//
//  AuthManager.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(userName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Kiểm tra userName hợp lệ
        // Kiểm tra email hợp lệ
        DatabaseManager.shared.canCreateNewUser(with: email, userName: userName) { canCreate in
            if canCreate {
                // Tạo tài khoản
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                        }
                        DatabaseManager.shared.insertNewUser(with: email, userName: userName) { inserted in
                            if inserted {
                                completion(true)
                                return
                            } else {
                                completion(false)
                                return
                            }
                        }
                    }

                } else {
                    completion(false)
                    // Nạp dữ liệu vào database
            }
        }
    }
    public func loginUser(userName: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let userName = userName {
            print(userName)
        }
    }
    // Cố gắng đăng xuất người dùng firebase
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
        
    }
}

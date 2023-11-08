//
//  DatabaseManager.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func canCreateNewUser(with email: String, userName: String, completion: (Bool) -> Void) {
        completion(true)
    }
    // Chèn dữ liệu người dùng mới vào cơ sở dữ liệu
         // tham số
             // email: String cho email
             // username: String cho tên người dùng
             // completion: Callback không đồng bộ cho kết quả nếu ghi database thành công
    public func insertNewUser(with email: String, userName: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": userName]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}

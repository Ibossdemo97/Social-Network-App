//
//  Models.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 20/10/2023.
//

import Foundation

enum Gender {
    case male, famale, orther
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}
struct User {
    let userName: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birth: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}
struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnallImage: URL
    let postURL: URL //video hoặc ảnh chất lượng đầy đủ
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let owner: User
}
struct PostComment {
    let identifier: String
    let userName: String
    let text: String
    let createDate: Date
    let likes: [CommentLikes]
}
struct PostLikes {
    let userName: String
    let postIdentifier: String
}
struct CommentLikes {
    let userName: String
    let commentIdentifier: String
}

//
//  NotificationViewController.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import UIKit

struct UserNotification {
    let type: UserNotificationtype
    let text: String
    let user: User
}
enum UserNotificationtype {
    case like(post: UserPost)
    case follow(state: FollowState)
}

final class NotificationViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = false
        table.register(NotificatonLikeEventTableViewCell.self,
                       forCellReuseIdentifier: NotificatonLikeEventTableViewCell.identifier)
        table.register(NotificatonFollowEventTableViewCell.self,
                       forCellReuseIdentifier: NotificatonFollowEventTableViewCell.identifier)
        return table
    }()
    private let spiner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationView = NoNotificationView()
    
    private var models = [UserNotification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNotification()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Thông báo"
        view.addSubview(tableView)
        view.addSubview(spiner)
//        spiner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func fetchNotification() {
        for i in 0...100 {
            let user = User(userName: "John",
                        bio: "",
                        name: (first: "", last: ""),
                        profilePhoto: URL(string: "https://www.google.com/")!,
                        birth: Date(),
                        gender: .male,
                        counts: UserCount(followers: 1,
                                          following: 1,
                                          posts: 1),
                        joinDate: Date())
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnallImage: URL(string: "https://www.google.com/")!,
                                postURL: URL(string: "https://www.google.com/")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [],
                                owner: user)
            let model = UserNotification(type: i % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hello ae",
                                         user: user)
            models.append(model)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spiner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spiner.center = view.center
    }
    private func addNoNotificationView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: view.width / 2,
                                          height: view.width / 4)
        noNotificationView.center = view.center
    }
}
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificatonLikeEventTableViewCell.identifier,
                                                     for: indexPath) as! NotificatonLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificatonFollowEventTableViewCell.identifier,
                                                     for: indexPath) as! NotificatonFollowEventTableViewCell
//            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}
extension NotificationViewController: NotificatonLikeEventTableViewCellDelegate, NotificatonFollowEventTableViewCellDelegate {
    func didTapRelatedPostBT(model: UserNotification) {
        // Mở post
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Lỗi")
        }
    }
    func didTapFollowUnfolowBT(model: UserNotification) {
        // Thực hiện cập nhật database
        print("Tapped button")
    }
}

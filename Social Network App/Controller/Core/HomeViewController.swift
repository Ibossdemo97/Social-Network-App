//
//  ViewController.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post : PostRenderViewModel
    let action: PostRenderViewModel
    let comment: PostRenderViewModel
}

class HomeViewController: UIViewController {

    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SNFeedPostTableViewCell.self,
                       forCellReuseIdentifier: SNFeedPostTableViewCell.identifier)
        table.register(SNFeedPostHeaderTableViewCell.self,
                       forCellReuseIdentifier: SNFeedPostHeaderTableViewCell.identifier)
        table.register(SNFeedPostActionsTableViewCell.self,
                       forCellReuseIdentifier: SNFeedPostActionsTableViewCell.identifier)
        table.register(SNFeedPostGeneralTableViewCell.self,
                       forCellReuseIdentifier: SNFeedPostGeneralTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func createMockModels() {
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
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                       userName: "Tony",
                                       text: "Đây là nơi tôi muốn tới",
                                       createDate: Date(),
                                       likes: []))
        }
        for i in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(rendertype: .header(provider: user)),
                                                    post: PostRenderViewModel(rendertype: .primaryContent(provider: post)),
                                                    action: PostRenderViewModel(rendertype: .actions(provider: "")),
                                                    comment: PostRenderViewModel(rendertype: .comment(comment: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
        
    }
    private func handleNotAuthenticated() {
        //Kiểm tra thông tin tài khoản
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
        
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let i = section
        var model: HomeFeedRenderViewModel
        if i == 0 {
            model = feedRenderModels[0]
        } else {
            let position = i % 4 == 0 ? i / 4 : ((i - (i % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = i %  4
        if subSection == 0 {
            return 1
        } else if subSection == 1 {
            return 1
        }  else if subSection == 2 {
            return 1
        }  else if subSection == 3 {
            let commentModel = model.comment
            switch commentModel.rendertype {
            case .comment(let comment): return comment.count > 2 ? 2 : comment.count
            case .header, .actions, .primaryContent:
                return 0
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.section
        var model: HomeFeedRenderViewModel
        if i == 0 {
            model = feedRenderModels[0]
        } else {
            let position = i % 4 == 0 ? i / 4 : ((i - (i % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = i % 4
        if subSection == 0 {
            switch model.header.rendertype {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostHeaderTableViewCell.identifier, for: indexPath) as! SNFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comment, .actions, .primaryContent:
                return UITableViewCell()
            }
        } else if subSection == 1 {
            switch model.post.rendertype {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostTableViewCell.identifier, for: indexPath) as! SNFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .header, .actions, .comment:
                return UITableViewCell()
            }
        }  else if subSection == 2 {
            switch model.action.rendertype {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostActionsTableViewCell.identifier, for: indexPath) as! SNFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .header, .primaryContent, .comment:
                return UITableViewCell()
            }
        }  else if subSection == 3 {
            switch model.comment.rendertype {
            case .comment(let comment):
                let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostGeneralTableViewCell.identifier, for: indexPath) as! SNFeedPostGeneralTableViewCell
                return cell
            case .header, .actions, .primaryContent:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section %  4
        if subSection == 0 {
            // Header
            return 70
        } else if subSection == 1 {
            // Post
            return tableView.width
        } else if subSection == 2 {
            // Action
            return 60
        } else if subSection == 3 {
            // Comment
            return 50
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if feedRenderModels.count % section == 0 {
            return 00
        }
        return 00
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}
extension HomeViewController: SNFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Option", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Báo cáo bài viết", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        actionSheet.addAction(UIAlertAction(title: "Bỏ qua", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    func reportPost() {
        
    }
}
extension HomeViewController: SNFeedPostActionsTableViewCellDelegate {
    func didTapLike() {
        print("like")
    }
    
    func didTapComment() {
        print("comment")
    }
    
    func didTapSend() {
        print("send")
    }
    
    
}

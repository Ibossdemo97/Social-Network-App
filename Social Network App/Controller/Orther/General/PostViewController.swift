//
//  PostViewController.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import UIKit

// Trạng thái của cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String) // like commnent share
    case comment(comment: [PostComment] )
}
// Model of rendered
struct PostRenderViewModel {
    let rendertype: PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
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
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureModels() {
        guard let userPosstModel = self.model else {
            return
        }
        // Header
        renderModels.append(PostRenderViewModel(rendertype: .header(provider: userPosstModel.owner)))
        // Post
        renderModels.append(PostRenderViewModel(rendertype: .primaryContent(provider: userPosstModel)))
        // Action
        renderModels.append(PostRenderViewModel(rendertype: .actions(provider: "")))
        // Comment
        var comment = [PostComment]()
        for i in 0..<4 {
            comment.append(PostComment(identifier: "123_\(i)",
                                       userName: "Keny",
                                       text: "Great Post!",
                                       createDate: Date(),
                                       likes: []))
        }
        renderModels.append(PostRenderViewModel(rendertype: .comment(comment: comment)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].rendertype {
        case .actions(_):
            return 1
        case .comment(let comment):
            return comment.count > 4 ? 4 : comment.count
        case .primaryContent(_):
            return 1
        case .header(_):
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.rendertype {
        case .actions(let action):
            let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostActionsTableViewCell.identifier, for: indexPath) as! SNFeedPostActionsTableViewCell
            return cell
        case .comment(let comment):
            let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostGeneralTableViewCell.identifier, for: indexPath) as! SNFeedPostGeneralTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostTableViewCell.identifier, for: indexPath) as! SNFeedPostTableViewCell
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: SNFeedPostHeaderTableViewCell.identifier, for: indexPath) as! SNFeedPostHeaderTableViewCell
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.rendertype {
        case .actions(_):
            return 60
        case .comment(_):
            return 50
        case .primaryContent(_):
            return tableView.width
        case .header(_):
            return 70
        }
    }
}

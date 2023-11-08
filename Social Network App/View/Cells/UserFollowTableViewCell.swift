//
//  UserFollowTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 23/10/2023.
//

import UIKit

protocol UserFollowTableViewCellDelegate {
    func didTapFollowToUnfollowT(model: UserRelationship)
}
enum FollowState {
    case following //Người dùng hiện tại đang theo dõi người dùng khác
    case not_following //Người dùng hiện tại KHÔNG theo dõi người dùng khác
}
struct UserRelationship {
    let userName: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowTableViewCell"
    
    var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "John"
        return label
    }()
    private let userNamelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Wick"
        label.textColor = .secondaryLabel
        return label
    }()
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Theo dõi", for: .normal)
        button.backgroundColor = .link
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(namelabel)
        contentView.addSubview(userNamelabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
    }
    @objc private func didTapFollow() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowToUnfollowT(model: model)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let buttonWidth = contentView.width > 500 ? 220 : contentView.width / 3
        followButton.frame = CGRect(x: contentView.width - 5 - buttonWidth,
                                    y: (contentView.height - 40) / 2,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height / 2
        namelabel.frame = CGRect(x: profileImageView.right + 5,
                                 y: 0,
                                 width: contentView.width - 3 - profileImageView.width - buttonWidth,
                                 height: labelHeight)
        userNamelabel.frame = CGRect(x: profileImageView.right + 5,
                                     y: namelabel.bottom,
                                     width: contentView.width - 3 - profileImageView.width - buttonWidth,
                                     height: labelHeight)
    }
    public func configure(with model: UserRelationship) {
        self.model = model
        namelabel.text = model.name
        userNamelabel.text = model.userName
        switch model.type {
        case .following:
            followButton.setTitle("Bỏ theo dõi", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            followButton.setTitle("Theo dõi", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        namelabel.text = nil
        userNamelabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.cornerRadius = 0
        followButton.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

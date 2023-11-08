//
//  NotificatonFollowEventTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 25/10/2023.
//

import UIKit

protocol NotificatonFollowEventTableViewCellDelegate : AnyObject {
    func didTapFollowUnfolowBT(model: UserNotification)
}

class NotificatonFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificatonFollowEventTableViewCell"
    
    weak var delegate: NotificatonFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .tertiarySystemBackground
        return image
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Ken bắt đầu theo dõi bạn"
        return label
    }()
    private let followBT: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followBT)
        followBT.addTarget(self, action: #selector(didTapFollowBT), for: .touchUpInside)
        
        configureForFollow()
        selectionStyle = .none
    }
    @objc private func didTapFollowBT() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfolowBT(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            switch state {
            case .following:
                configureForFollow()
            case .not_following:
                followBT.setTitle("Theo dõi", for: .normal)
                followBT.setTitleColor(.white, for: .normal)
                followBT.layer.borderWidth = 0
                followBT.backgroundColor = .link
            }
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    private func configureForFollow() {
        followBT.setTitle("Bỏ theo dõi", for: .normal)
        followBT.setTitleColor(.label, for: .normal)
        followBT.layer.borderWidth = 1
        followBT.layer.borderColor = UIColor.secondaryLabel.cgColor
        
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        followBT.setTitle(nil, for: .normal)
        followBT.backgroundColor = nil
        followBT.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3,
                                        width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followBT.frame = CGRect(x: contentView.width - 5 - size,
                                y: (contentView.height - buttonHeight) / 2,
                                width: size,
                                height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right + 5, y: 0,
                             width: contentView.width - size - profileImageView.width - 16,
                             height: contentView.height)
    }
    
}

//
//  NotificatonLikeEventTableViewCellTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 25/10/2023.
//

import UIKit
import SDWebImage

protocol NotificatonLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostBT(model: UserNotification)
}

class NotificatonLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificatonLikeEventTableViewCell"
    
    weak var delegate: NotificatonLikeEventTableViewCellDelegate?
    
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
        label.text = "John thích bài viết của bạn"
        return label
    }()
    private let postBT: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "text"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postBT)
        postBT.addTarget(self, action: #selector(didTapPostBT), for: .touchUpInside)
        
        selectionStyle = .none
    }
    @objc private func didTapPostBT() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostBT(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnallImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postBT.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    public override func prepareForReuse() {
        super.prepareForReuse()
        postBT.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3,
                                        width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size = contentView.height - 4
        postBT.frame = CGRect(x: contentView.width - 5 - size, y: 0, width: size, height: size)
        
        label.frame = CGRect(x: profileImageView.right + 5, y: 0,
                             width: contentView.width - size - profileImageView.width - 16,
                             height: contentView.height)
    }
    
}

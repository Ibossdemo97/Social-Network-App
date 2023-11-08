//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 19/10/2023.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostBT(_ header: ProfileInfoHeaderCollectionReusableView)
    
    func profileHeaderDidTapFollowersBT(_ header: ProfileInfoHeaderCollectionReusableView)
    
    func profileHeaderDidTapFollowingBT(_ header: ProfileInfoHeaderCollectionReusableView)
    
    func profileHeaderDidTapEditProfileBT(_ header: ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Bài viết", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    private let followersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Người theo dõi", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Đang theo dõi", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Chỉnh sửa hồ sơ của bạn", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Some One"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Đây là tài khoản đầu tiên của tôi"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        addButtonAction()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    private func addSubview() {
        addSubview(profilePhotoImageView)
        addSubview(postButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    private func addButtonAction() {
        postButton.addTarget(self, action: #selector(didTapPostBT), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersBT), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingBT), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileBT), for: .touchUpInside)
    }
    @objc private func didTapPostBT() {
        delegate?.profileHeaderDidTapPostBT(self)
    }
    @objc private func didTapFollowersBT() {
        delegate?.profileHeaderDidTapFollowersBT(self)
    }
    @objc private func didTapFollowingBT() {
        delegate?.profileHeaderDidTapFollowingBT(self)
    }
    @objc private func didTapEditProfileBT() {
        delegate?.profileHeaderDidTapEditProfileBT(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let avatarsSize_BTWidth_BTHeight = [width / 4, width / 8, (width - 10 - (width / 4)) / 3]
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: avatarsSize_BTWidth_BTHeight[0],
                                             height: avatarsSize_BTWidth_BTHeight[0])
                    .integral
        profilePhotoImageView.layer.cornerRadius = avatarsSize_BTWidth_BTHeight[1]
        postButton.frame = CGRect(x: profilePhotoImageView.right,
                                  y: 5,
                                  width: avatarsSize_BTWidth_BTHeight[2],
                                  height: avatarsSize_BTWidth_BTHeight[1])
                    .integral
        followersButton.frame = CGRect(x: postButton.right,
                                       y: 5,
                                       width: avatarsSize_BTWidth_BTHeight[2],
                                       height: avatarsSize_BTWidth_BTHeight[1])
                    .integral
        followingButton.frame = CGRect(x: followersButton.right,
                                       y: 5,
                                       width: avatarsSize_BTWidth_BTHeight[2],
                                       height: avatarsSize_BTWidth_BTHeight[1])
                    .integral
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                         y: 5 + avatarsSize_BTWidth_BTHeight[1],
                                         width: postButton.width * 3,
                                         height: avatarsSize_BTWidth_BTHeight[1])
                    .integral
        nameLabel.frame = CGRect(x: 5,
                                 y: 5 + profilePhotoImageView.bottom,
                                 width: width - 10,
                                 height: avatarsSize_BTWidth_BTHeight[1])
                    .integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5,
                                y: 5 + nameLabel.bottom,
                                width: width - 10,
                                height: bioLabelSize.height)
                    .integral
    }
}

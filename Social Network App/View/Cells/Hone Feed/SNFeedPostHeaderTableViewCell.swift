//
//  SNFeedPostHeaderTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 14/10/2023.
//

import UIKit
import SDWebImage

protocol SNFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class SNFeedPostHeaderTableViewCell: UITableViewCell {
    
    weak var delegate: SNFeedPostHeaderTableViewCellDelegate?

    static let identifier = "SNFeedPostHeaderTableViewCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .link
        return imageView
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model: User) {
        userNameLabel.text = model.userName
        avatarImageView.image = UIImage(systemName: "person.circle")
        
    }
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height - 4
        avatarImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        avatarImageView.layer.cornerRadius = size / 2
        
        moreButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        
        userNameLabel.frame = CGRect(x: avatarImageView.right + 10,
                                     y: 2,
                                     width: contentView.width - (size * 2) - 15,
                                     height: contentView.height - 4)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userNameLabel.text = nil
        avatarImageView.image = nil
    }
    
}

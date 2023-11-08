//
//  SNFeedPostActionsTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 14/10/2023.
//

import UIKit

protocol SNFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLike()
    func didTapComment()
    func didTapSend()
}

class SNFeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "SNFeedPostActionsTableViewCell"
    
    weak var delegate: SNFeedPostActionsTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeBT), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentBT), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendBT), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func didTapLikeBT() {
        delegate?.didTapLike()
    }
    @objc private func didTapCommentBT() {
        delegate?.didTapComment()
    }
    @objc private func didTapSendBT() {
        delegate?.didTapSend()
    }
    
    public func configure(with post: UserPost) {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize = contentView.height - 10
        let buttons = [likeButton, commentButton, sendButton]
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.frame = CGRect(x: (CGFloat(i) * buttonSize) + (10 * CGFloat(i + 1)), y: 5,
                                  width: buttonSize, height: buttonSize)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

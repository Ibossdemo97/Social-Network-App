//
//  SNFeedTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 14/10/2023.
//

import UIKit
import AVFoundation
import SDWebImage

final class SNFeedPostTableViewCell: UITableViewCell {

    static let identifier = "SNFeedTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(postImageView)
        contentView.layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with post: UserPost) {
        imageView?.image = UIImage(named: "text")
        return
        switch post.postType {
        case .photo:
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            player = AVPlayer(url: post.postURL)
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}

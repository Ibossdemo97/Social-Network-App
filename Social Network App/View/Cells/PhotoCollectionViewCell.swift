//
//  PhotoCollectionViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 19/10/2023.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "avatar"
        accessibilityHint = "Double tap"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model: UserPost) {
        let url = model.thumbnallImage
        photoImageView.sd_setImage(with: url, completed: nil)
    }
    public func configure(debug imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }
}

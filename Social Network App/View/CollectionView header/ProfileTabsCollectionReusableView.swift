//
//  ProfileTabsCollectionReusableView.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 19/10/2023.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridTabBT()
    func didTapTaggedTabBT()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = { //Thay đổi kiểu hiện thị
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .secondarySystemBackground
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        
        gridButton.addTarget(self, action: #selector(didTapGridBT), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedBT), for: .touchUpInside)
    }
    @objc private func didTapGridBT() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridTabBT()
    }
    @objc private func didTapTaggedBT() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedTabBT()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size_halfWidth = [height - 4, ((width / 2) - (height - 4)) / 2]
        
        gridButton.frame = CGRect(x: size_halfWidth[1],
                                  y: Constants.padding,
                                  width: size_halfWidth[0],
                                  height: size_halfWidth[0])
        
        taggedButton.frame = CGRect(x: size_halfWidth[1] + (width / 2),
                                    y: Constants.padding,
                                    width: size_halfWidth[0],
                                    height: size_halfWidth[0])
    }
}

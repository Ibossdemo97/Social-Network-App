//
//  SNFeedPostGenaralTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 14/10/2023.
//

import UIKit

class SNFeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "SNFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure() {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    

}

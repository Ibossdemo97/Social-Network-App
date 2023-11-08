//
//  FromTableViewCell.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 19/10/2023.
//

import UIKit

protocol FromTableViewCellDelegate {
    func fromTableViewCell(_ cell: FromTableViewCell, didUpdateField updateModel: EditProfileFormModel)
}

class FromTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "FromTableViewCell"
    
    private var model: EditProfileFormModel?
    
    public var delegate: FromTableViewCellDelegate?
    
    private let fromLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(fromLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        fromLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        fromLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fromLabel.frame = CGRect(x: 5, y: 0,
                                 width: contentView.width / 3, height: contentView.height)
        field.frame = CGRect(x: fromLabel.right + 5, y: 0,
                             width: contentView.width - 10 - fromLabel.width, height: contentView.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.fromTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}

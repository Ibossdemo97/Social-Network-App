//
//  EditProfileViewController.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let taleView = UITableView()
        taleView.register(FromTableViewCell.self, forCellReuseIdentifier: FromTableViewCell.identifier)
        return taleView
    }()
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createHeader()
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Lưu",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapCancel))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Huỷ",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func configureModels() {
        let section1Labels = ["Name", "Username", "Tiểu sử"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Nhập \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        let section2Labels = ["Email", "Số điện thoại", "Giới tính"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Nhập \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    private func createHeader() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height / 4).integral)
        let size = header.height / 1.5
        let profilePhoto = UIButton(frame: CGRect(x: (view.width - size) / 2,
                                                  y: (header.height - size) / 2,
                                                  width: size,
                                                  height: size))
        header.addSubview(profilePhoto)
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = size / 2
        profilePhoto.tintColor = .label
        profilePhoto.addTarget(self, action: #selector(didTapProfilePhotoBT), for: .touchUpInside)
        profilePhoto.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    @objc private func didTapProfilePhotoBT() {
        
    }
    @objc private func didTapSave() {
        dismiss(animated: true, completion: nil)
        
    }
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Ảnh đại diện",
                                            message: "Thay đổi ảnh đai diện",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Chụp ảnh", style: .default, handler:  { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Chọn ảnh", style: .default, handler:  { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Bỏ qua", style: .default, handler:  { _ in
            
        }))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
    }
}
extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate, FromTableViewCellDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FromTableViewCell.identifier, for: indexPath) as! FromTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Thông tin riêng tư"
    }
    func fromTableViewCell(_ cell: FromTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
        // Câp nhật model
    }
}

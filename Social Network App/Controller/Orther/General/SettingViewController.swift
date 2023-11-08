//
//  SettingViewController.swift
//  Social Network App
//
//  Created by Luyện Hà Luyện on 10/10/2023.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let hander: (() -> Void)
}

class SettingViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        configureModels()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func configureModels() {
        data.append([
            SettingCellModel(title: "Chỉnh sửa tài khoản") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Thêm bạn bè") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Lưu bài viết") { [weak self] in
                self?.didTapSavePost()
            }
        ])
        data.append([
            SettingCellModel(title: "Điều khoản dịch vụ") { [weak self] in
                self?.didTapTermsBT()
            },
            SettingCellModel(title: "Chính sách sử dụng") { [weak self] in
                self?.didTapPrivacyBT()
            },
            SettingCellModel(title: "Trợ giúp / Phản hồi") { [weak self] in
                self?.didTapHelpBT()
            }
        ])
        data.append([
            SettingCellModel(title: "Đăng xuất") { [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Đăng xuất",
                                           message: "Bạn chắc chắn muốn đăng xuất",
                                           preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Bỏ qua",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Đăng xuất",
                                            style: .destructive,
                                            handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        fatalError("Không thể đăng xuất")
                    }
                }
            })
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
    }
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Chỉnh sửa tài khoản"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    private func didTapInviteFriends() {
        
    }
    private func didTapSavePost() {
        
    }
    private func didTapTermsBT() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    private func didTapPrivacyBT() {
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    private func didTapHelpBT() {
        guard let url = URL(string: "https://help.instagram.com/contact/505535973176353") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].hander()
    }
    
}

//
//  SettingsViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

import SafariServices

/// 유저 정보 세팅
final class SettingsViewController: UIViewController {

    // MARK: - Properties
    let cellIdentifier: String = "cell"

    enum SettingURLType {
        case terms
        case privacy
        case help
    }

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var data = [[SettingCellModel]]()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        configureModels()
    }

    override func viewDidLayoutSubviews() {
        // set frame UI Component
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    /// 기본 정보 셋팅
    private func configureModels() {
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in //
                guard let self = self else { return }
                self.didTapEditprofile()
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in //
                guard let self = self else { return }
                self.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in //
                guard let self = self else { return }
                self.didTapSaveOriginalPosts()
            }
            ])

        data.append([
            SettingCellModel(title: "Terms of service") { [weak self] in // handler: () -> Void
                guard let self = self else { return }
                self.openURL(type: .terms)
            }
            ])

        data.append([
            SettingCellModel(title: "Privacy Policy") { [weak self] in // handler: () -> Void
                guard let self = self else { return }
                self.openURL(type: .privacy)
            }
            ])

        data.append([
            SettingCellModel(title: "Help / Feedback") { [weak self] in // handler: () -> Void
                guard let self = self else { return }
                self.openURL(type: .help)
            }
            ])

        data.append([
            SettingCellModel(title: "Logout") { [weak self] in // handler: () -> Void
                guard let self = self else { return }
                self.didTapLogout() // configureModels 호출시 didTapLogout 호출하도록 정의
            }
            ])
    }

    
    /// 프로필 이미지 터치시 작동할 메소드
    private func didTapEditprofile() {
        let editprofileVC = EditProfileViewController()
        editprofileVC.title = "Edit Profile"
        let navigationVC = UINavigationController(rootViewController: editprofileVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true, completion: nil)
    }

    private func didTapInviteFriends() {
        // show share sheet to invite

    }

    private func didTapSaveOriginalPosts() {

    }

    private func openURL(type: SettingURLType) {
        let urlString: String
        switch type {
        case .terms:
            urlString = Constants.termsOfServiceURL

        case .privacy:
            urlString = Constants.privacyURL

        case .help:
            urlString = Constants.helpCenterURL
        }

        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

    private func didTapLogout() {
        let actionSheet: UIAlertController = UIAlertController(title: "Logout",
            message: "정말 로그아웃 하시겠습니까?",
            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
            style: .cancel,
            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Logout",
            style: .destructive,
            handler: { _ in
                // logout logic
                AuthManager.shared.logout { [weak self] didLogout in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        if didLogout {
                            // present login
                            let loginVC = LoginViewController()
                            loginVC.modalPresentationStyle = .fullScreen
                            self.present(loginVC, animated: true) {
                                self.navigationController?.popToRootViewController(animated: false)
                                self.tabBarController?.selectedIndex = 0
                            }
                        } else {
                            fatalError("Logout Error")
                        }
                    }
                }
            })
        )
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        let model = data[indexPath.section][indexPath.row]
        cell.textLabel?.text = model.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler() // logout 셀 터치시 model.handler가 실행되면서 didTapLogout() 호출
    }
}

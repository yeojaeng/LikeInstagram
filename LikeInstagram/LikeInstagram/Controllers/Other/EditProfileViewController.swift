//
//  EditProfileViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    // MARK: - Properties

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self,
                           forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()

    private var models: [[EditProfileFormModel]] = [[EditProfileFormModel]]()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupBarbutton()
        setupTableView()
        configureModels()
    }

    private func setupBarbutton() {
        let saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save",
                                                          style: .done,
                                                          target: self,
                                                          action: #selector(didTapSaveBtn))
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancelBtn))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.setNeedsLayout()      // udpate layout async
    }

    /// Setup models data
    private func configureModels() {
        // section1 -> User Info
        let firstSectionLabel = ["Name", "Username", "Bio"]
        var firstSection = [EditProfileFormModel]()
        firstSectionLabel.forEach { labelText in
            let model = EditProfileFormModel(label: labelText, placeholder: "Enter \(labelText)", value: nil)
            firstSection.append(model)
        }
        models.append(firstSection) // models[0][0]

        // section2 -> Privacy Information
        let secondSectionLabel = ["Email", "Phone", "Gender"]
        var secondSection = [EditProfileFormModel]()
        secondSectionLabel.forEach { labelText in
            let model = EditProfileFormModel(label: labelText, placeholder: "Enter \(labelText)", value: nil)
            secondSection.append(model)
        }
        models.append(secondSection)    // models[1][0]
    }

    /// make tableView's header view
    /// - Returns: UIView be located header
    private func createTableHeaderView() -> UIView {
        let header: UIView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.width,
                                                  height: view.height / 4))
        let size = header.height / 1.5
        let profileImageButton: UIButton = UIButton(frame: CGRect(x: (view.width - size) / 2,
                                                                  y: (header.height - size) / 2,
                                                                  width: size,
                                                                  height: size))
        profileImageButton.layer.masksToBounds = true
        profileImageButton.layer.cornerRadius = size / 2
        profileImageButton.layer.borderWidth = 1
        profileImageButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profileImageButton.tintColor = .label
        profileImageButton.addTarget(self,
                                     action: #selector(didTapProfileImageButton),
                                     for: .touchUpInside)
        profileImageButton.setBackgroundImage(UIImage(systemName: "person.circle"),
                                              for: .normal)

        header.addSubview(profileImageButton)
        return header
    }

    @objc private func didTapProfileImageButton() {

    }

    @objc private func didTapSaveBtn() {
        // save info to DB
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapCancelBtn() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapChangeProfilePicture() {
        let actionSheet: UIAlertController = UIAlertController(title: "프로필 이미지",
            message: "프로필 이미지 변경",
            preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "사진 촬영",
            style: .default,
            handler: { _ in

            }))

        actionSheet.addAction(UIAlertAction(title: "갤러리에서 선택",
            style: .default,
            handler: { _ in

            }))

        actionSheet.addAction(UIAlertAction(title: "취소",
            style: .cancel,
            handler: nil))

        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - TableView Datasource Methods
extension EditProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }

    // Custom Delegate 패턴 적용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        guard let cell: FormTableViewCell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier,
                                                                          for: indexPath) as? FormTableViewCell else { return UITableViewCell() }

        cell.delegate = self        // cell's delegate is VC
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return "User Info"
        }
        return "Privacy Information"
    }
}

// MARK: - Custom Delegate mehtod
extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
        // check
    }
}

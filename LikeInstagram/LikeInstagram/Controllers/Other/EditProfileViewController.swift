//
//  EditProfileViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSaveBtn))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancelBtn))
    }

    @objc private func didTapSaveBtn() {

    }

    @objc private func didTapCancelBtn() {

    }

    @objc private func didTapChangeProfilePicture() {
        let actionSheet: UIAlertController = UIAlertController(title: "Profile Picture",
                                                               message: "Change profile picture",
                                                               preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { _ in

            }))

        actionSheet.addAction(UIAlertAction(title: "Choose from library",
                                            style: .default,
                                            handler: { _ in

            }))

        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))

        present(actionSheet, animated: true, completion: nil)
    }
}

//
//  ProfileInfoHeaderCollectionReusableView.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/25.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollwersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollwingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

// Headerview for ProfileVC
final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {

    // MARK: - Properties

    static let identifier: String = "ProfileInfoHeaderCollectionReusableView"

    // delegate
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?

    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jungsu YEO"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the first account"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Methods

    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubViews()
        addButtonActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Set UI Frame
    override func layoutSubviews() {
        super.layoutSubviews()

        let profilePhotoSize = width / 4
        profilePhotoImageView.frame = CGRect(x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize).integral

        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2

        let buttonHeight = profilePhotoSize / 2
        let countButtonWidth = (width - 10 - profilePhotoSize) / 3

        postButton.frame = CGRect(x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral

        followersButton.frame = CGRect(x: postButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral

        followingButton.frame = CGRect(x: followersButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral

        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
            y: buttonHeight,
            width: countButtonWidth * 3,
            height: buttonHeight).integral

        nameLabel.frame = CGRect(x: 5,
            y: 5 + profilePhotoImageView.bottom,
            width: width - 10,
            height: 50).integral

        let bioLabelSize = bioLabel.sizeThatFits(self.frame.size)

        bioLabel.frame = CGRect(x: 5,
            y: 5 + nameLabel.bottom,
            width: width - 10,
            height: bioLabelSize.height).integral
    }

    private func addSubViews() {
        self.addSubview(profilePhotoImageView)
        self.addSubview(postButton)
        self.addSubview(followingButton)
        self.addSubview(followersButton)
        self.addSubview(editProfileButton)
        self.addSubview(nameLabel)
        self.addSubview(bioLabel)
    }

    private func addButtonActions() {
        followersButton.addTarget(self,
            action: #selector(didTapFollowersButton),
            for: .touchUpInside)
        followingButton.addTarget(self,
            action: #selector(didTapFollowingButton),
            for: .touchUpInside)
        postButton.addTarget(self,
            action: #selector(didTapPostButton),
            for: .touchUpInside)
        editProfileButton.addTarget(self,
            action: #selector(didTapEditProfileButton),
            for: .touchUpInside)
    }

    // MARK: - Delegate Actions

    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollwersButton(self)
    }

    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollwingButton(self)
    }

    @objc private func didTapPostButton() {
        delegate?.profileHeaderDidTapPostButton(self)
    }

    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}

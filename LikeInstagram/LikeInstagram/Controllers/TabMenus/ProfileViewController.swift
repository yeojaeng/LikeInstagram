//
//  ProfileViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

/// 유저 프로필 컨트롤러
final class ProfileViewController: UIViewController {

    // MARK: - Properties

    private var collectionView: UICollectionView?
    private var userPosts: [UserPost] = []

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        setupCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

    private func configureNavigationBar() {
        let rightBarBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
            style: .done,
            target: self,
            action: #selector(didTapSettingButton))
        navigationItem.rightBarButtonItem = rightBarBtn
    }

    private func setupCollectionView() {
        // set layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width: CGFloat = view.width
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: (width / 3) - 1, height: (width / 3))
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        // set collectionview
        collectionView = UICollectionView(frame: .zero,
            collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.backgroundColor = .systemBackground
        // regist Cell
        collectionView.register(PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        // regist Header
        collectionView.register(ProfileInfoHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)

        collectionView.register(ProfileTabsCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }

    @objc private func didTapSettingButton() {
        let settingVC = SettingsViewController()
        settingVC.title = "Settings"
        navigationController?.pushViewController(settingVC, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        // return userPost.count

        return 30 // section 1 for post image
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
//        let model = userPosts[indexPath.row]
//        cell.configure(with: model)
        cell.configure(with: "test")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        // get model and open post VC
        let model = userPosts[indexPath.row]
        // 선택한 모델을 전달
        let postVC: PostViewController = PostViewController(model: model)
        postVC.title = "Post"
        postVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(postVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            // footer
            return UICollectionReusableView()
        }

        if indexPath.section == 1 {
            // 탭바 헤더 생성
            guard let tabsHeader: UICollectionReusableView =
                collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                    withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                    for: indexPath) as? ProfileTabsCollectionReusableView else { return ProfileTabsCollectionReusableView() }

            return tabsHeader
        }

        // headerView 생성
        guard let profileHeaderView: ProfileInfoHeaderCollectionReusableView =
            collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                for: indexPath) as? ProfileInfoHeaderCollectionReusableView else { return ProfileInfoHeaderCollectionReusableView()
        }
        profileHeaderView.delegate = self
        return profileHeaderView
    }

    // 헤더 뷰의 사이즈 높이 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // profile 헤더 뷰 사이즈
        if section == 0 {
            return CGSize(width: collectionView.width,
                height: collectionView.height / 3)
        }

        // 탭바 헤더 사이즈
        return CGSize(width: collectionView.width,
            height: 65)
    }
}

// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {

    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to posts section
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }

    func profileHeaderDidTapFollwersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let listVC = ListViewController()
        listVC.title = "Followers"
        listVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(listVC, animated: true)
    }

    func profileHeaderDidTapFollwingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let listVC = ListViewController()
        listVC.title = "Following"
        listVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(listVC, animated: true)
    }

    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let editProfileVC = EditProfileViewController()
        editProfileVC.title = "Edit Profile"
        present(UINavigationController(rootViewController: editProfileVC), animated: true, completion: nil)
    }
}

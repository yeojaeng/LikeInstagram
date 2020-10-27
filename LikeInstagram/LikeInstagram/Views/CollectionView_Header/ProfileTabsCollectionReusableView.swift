//
//  ProfileTabsCollectionReusableView.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/25.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier: String = "ProfileTabsCollectionReusableView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  FeedPostTableViewCell.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/25.
//

import UIKit

// HomeVC 포스트 게시글 커스텀 셀
class FeedPostTableViewCell: UITableViewCell {

    static let identifier: String = "FeedPostTableViewCell"

    // Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure() {
        // configure the cell

    }
}

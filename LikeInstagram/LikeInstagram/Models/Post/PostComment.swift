//
//  PostComment.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/27.
//

import Foundation

// PostComment Model
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

struct CommentLike {
    let commentIdentifier: String
    let username: String
}

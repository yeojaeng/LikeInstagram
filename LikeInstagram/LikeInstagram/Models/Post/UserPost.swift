//
//  UserPost.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/27.
//

import Foundation

enum UserPostType {
    case photo
    case video
}

// UserPost Model
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let postedDate: Date
    let taggedUsers: [String]
}

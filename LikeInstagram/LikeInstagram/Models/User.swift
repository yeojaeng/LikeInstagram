//
//  User.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/27.
//

import Foundation

enum Gender {
    case male
    case female
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let count: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

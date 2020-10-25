//
//  DatabaseManager.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import Foundation

import FirebaseDatabase

public class DatabaseManager {

    // Singleton Object
    static let shared = DatabaseManager()
    private let database = Database.database().reference()

    private init() { }

    // MARK: - Public

    /// 계정 생성 가능여부 확인
    /// - Parameters:
    ///   - email: 사용자 email 정보
    ///   - username: 사용자 이름 정보
    ///   - completion: 결과값 반환
    public func canCreateNewuser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }

    /// 계정을 DB에 저장
    /// - Parameters:
    ///   - email: 사용자 email 정보
    ///   - username: 사용자 이름 정보
    ///   - completion: 결과값 반환
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        // email : [username: username]
        database.child(email.makeSafeEmail()).setValue(["username": username]) { error, _ in
            if error == nil {
                // success
                completion(true)
                return
            } else {
                // fail
                completion(false)
                return
            }
        }
    }
}

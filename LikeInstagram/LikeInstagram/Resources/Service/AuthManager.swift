//
//  AuthManager.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import Foundation

import FirebaseAuth

public class AuthManager {

    // Singleton Object
    static let shared = AuthManager()

    private init() { }

    // MARK: - Public

    /// 새로운 계정 생성
    /// - Parameters:
    ///   - username: 사용자 이름 정보
    ///   - email: 사용자 이메일 정보
    ///   - passwored: 사용자 비밀번호 정보
    ///   - completion: 결과값 반환
    public func registerNewUser(username: String, email: String, passwored: String, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewuser(with: email, username: username) { canCreate in
            if canCreate {
                // create Account
                Auth.auth().createUser(withEmail: email, password: passwored) { (result, error) in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    // Insert Account to DB
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { isInserted in
                        if isInserted {
                            completion(true)
                            return
                        } else {
                            // fail insert to DB
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }

    /// 로그인 유효 검증 함수
    /// - Parameters:
    ///   - username: 사용자 이름 정보
    ///   - email: 사용자 이메일 정보
    ///   - password: 사용자 비밀번호 정보
    ///   - completion: 결과값 반환
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)) {
        if let email = email {
            // login with email
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard result != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }

        } else if let username = username {
            // login with username
            print(username)
        }
    }

    /// Logout 함수
    /// - Parameter completion: 결과값 반환
    public func logout(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error.localizedDescription)
            completion(false)
            return
        }
    }
}

//
//  StorageManager.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import Foundation

import FirebaseStorage

enum StorageManagerError: Error {
    case downloadFail
}

public class StorageManager {

    // Singleton Object
    static let shared = StorageManager()

    private let storage = Storage.storage().reference()

    private init() { }

    // MARK: - Public

    public func uploadUserPhotoPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {

    }

    public func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void) {
        storage.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageManagerError.downloadFail))
                return
            }
            completion(.success(url))
        }
    }
}

//
//  ViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        handleNotAuthenticated()
    }

    fileprivate func handleNotAuthenticated() {
        // Check auth status
        if Auth.auth().currentUser == nil {
            // show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

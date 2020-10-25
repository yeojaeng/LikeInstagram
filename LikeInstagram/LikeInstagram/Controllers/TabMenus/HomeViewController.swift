//
//  ViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

import FirebaseAuth

class HomeViewController: UIViewController {

    // MARK: Properties

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostTableViewCell.self,
                           forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        return tableView
    }()

    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        checkAuthStatus()
    }

    override func viewDidLayoutSubviews() {
        // set frame
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func checkAuthStatus() {
        // Check auth status
        if Auth.auth().currentUser == nil {
            // show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

// MARK: - Delegate & Datasource Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FeedPostTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier) as? FeedPostTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

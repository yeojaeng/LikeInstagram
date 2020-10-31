//
//  PostViewController.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

class PostViewController: UIViewController {

    // MARK: - Properties

    private let model: UserPost?
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    // MARK: - Methods

    // Init: 객체 생성시 model을 인자로 받도록 한다.
    init(model: UserPost) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    // Set UI frame
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

// MARK: - Tableview Delegate & Datasources Methods

extension PostViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

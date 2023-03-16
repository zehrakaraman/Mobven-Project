//
//  HomeViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 16.03.2023.
//

import UIKit

class HomeViewController: UIViewController, HTTPClient {

    @IBOutlet weak var chatList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatList.delegate = self
        chatList.dataSource = self
        chatList.register(UINib(nibName: "ChatListTableViewCell", bundle: .main), forCellReuseIdentifier: "ChatListTableViewCell")

    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        // configure the cell
        return cell
    }
}

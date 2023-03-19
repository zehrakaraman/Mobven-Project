//
//  HomeViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayAllGroups(viewModel: Home.Case.ViewModel)
}

final class HomeViewController: UIViewController, HTTPClient {
    
    @IBOutlet weak var chatList: UITableView!
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var viewModel: Home.Case.ViewModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatList.delegate = self
        chatList.dataSource = self
        chatList.register(UINib(nibName: "ChatListTableViewCell", bundle: .main), forCellReuseIdentifier: "ChatListTableViewCell")
        
        interactor?.fetchData()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayAllGroups(viewModel: Home.Case.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.chatList.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.allGroupsListViewModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as? ChatListTableViewCell,
              let model = viewModel?.allGroupsListViewModel[indexPath.row]
              else { return UITableViewCell() }
        cell.configure(user: model)
        return cell
    }
}

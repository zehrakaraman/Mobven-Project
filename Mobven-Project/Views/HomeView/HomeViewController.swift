//
//  HomeViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayAllGroups(viewModel: [Home.Case.ViewModel.GroupsModel])
    func displayAllUsers(viewModel: [Home.Case.ViewModel.User])
}

final class HomeViewController: UIViewController, HTTPClient {
    
    @IBOutlet weak var authorizedUserName: UILabel!
    @IBOutlet weak var communityList: UICollectionView!
    @IBOutlet weak var chatList: UITableView!
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var groupsViewModel: [Home.Case.ViewModel.GroupsModel]?
    var usersViewModel: [Home.Case.ViewModel.User]?
    
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
        
        authorizedUserName.text = router?.dataStore?.authorizedUser?.fullName
        
        chatList.layer.cornerRadius = 20
                
        // MARK: Setup the views
        
        communityList.delegate = self
        communityList.dataSource = self
        
        chatList.delegate = self
        chatList.dataSource = self
        
        // MARK: Register the cells
        
        communityList.register(HeaderView.self,
                               forSupplementaryViewOfKind: HeaderView.elementKind,
                               withReuseIdentifier: HeaderView.identifier)
        communityList.register(.init(nibName: MainCollectionViewCell.nibName, bundle: .main),
                               forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        chatList.register(.init(nibName: ChatListTableViewCell.nibName, bundle: .main),
                          forCellReuseIdentifier: ChatListTableViewCell.identifier)
        
        interactor?.fetchData()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {        
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
    func displayAllGroups(viewModel: [Home.Case.ViewModel.GroupsModel]) {
        self.groupsViewModel = viewModel
        DispatchQueue.main.async {
            guard let cell = self.communityList.cellForItem(at: IndexPath(item: 0, section: 0)) as? MainCollectionViewCell else { return }
            cell.viewModel = self.groupsViewModel
        }
    }
    
    func displayAllUsers(viewModel: [Home.Case.ViewModel.User]) {
        self.usersViewModel = viewModel
        DispatchQueue.main.async {
            self.chatList.reloadData()
        }
    }
}

// MARK: Configure the collection view

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: 305, height: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 165)
    }
}

// MARK: Configure the table view

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as? ChatListTableViewCell,
              let model = usersViewModel?[indexPath.row] else { return UITableViewCell() }
        cell.configure(user: model)
        return cell
    }
}

//
//  HomeRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToChat(index: Int)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    func routeToChat(index: Int) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let destinationView = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        destinationView.router?.dataStore?.authorizedUser = dataStore?.authorizedUser
        destinationView.router?.dataStore?.user = viewController?.usersViewModel?[index]
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
}

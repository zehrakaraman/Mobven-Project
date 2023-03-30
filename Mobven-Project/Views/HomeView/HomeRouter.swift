//
//  HomeRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    func routeToChat(index: Int) {
        
    }
}

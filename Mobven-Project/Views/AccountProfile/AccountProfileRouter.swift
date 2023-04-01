//
//  AccountProfileRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import UIKit

protocol AccountProfileRoutingLogic: AnyObject {
    
}

protocol AccountProfileDataPassing: AnyObject {
    var dataStore: AccountProfileDataStore? { get }
}

final class AccountProfileRouter: AccountProfileRoutingLogic, AccountProfileDataPassing {
    
    weak var viewController: AccountProfileViewController?
    var dataStore: AccountProfileDataStore?

}

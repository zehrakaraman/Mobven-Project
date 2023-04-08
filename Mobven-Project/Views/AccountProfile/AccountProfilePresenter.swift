//
//  AccountProfilePresenter.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import Foundation

protocol AccountProfilePresentationLogic: AnyObject {
    func presentProfile(model: Account)
}

final class AccountProfilePresenter: AccountProfilePresentationLogic {
    
    weak var viewController: AccountProfileDisplayLogic?
    
    func presentProfile(model: Account) {
        viewController?.displayProfile(viewModel: model)
    }
}

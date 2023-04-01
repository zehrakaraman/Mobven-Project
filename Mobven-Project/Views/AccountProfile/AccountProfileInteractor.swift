//
//  AccountProfileInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import Foundation

protocol AccountProfileBusinessLogic: AnyObject {
    
}

protocol AccountProfileDataStore: AnyObject {
    
}

final class AccountProfileInteractor: AccountProfileBusinessLogic, AccountProfileDataStore {
    
    var presenter: AccountProfilePresentationLogic?
    var worker: AccountProfileWorkingLogic = AccountProfileWorker()
    
}

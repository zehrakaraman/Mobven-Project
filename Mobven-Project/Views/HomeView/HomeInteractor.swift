//
//  HomeInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchData()
}

protocol HomeDataStore: AnyObject {
    var authorizedUser: Authorized? { get set }
    var allGroupsResponse: AllGroupsResponse? { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    var authorizedUser: Authorized?
    var allGroupsResponse: AllGroupsResponse?
    var allUsersResponse: AllUsersResponse?
    
    func fetchData() {
        guard let authorizedUser = authorizedUser else { return }
        
        worker.fetchAllGroups(token: authorizedUser.accessToken) { result in
            switch result {
            case .success(let response):
                self.allGroupsResponse = response
                guard let allGroupsResponse = self.allGroupsResponse else { return }
                self.presenter?.presentAllGroups(response: allGroupsResponse.body.groups)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        worker.fetchAllUsers(token: authorizedUser.accessToken) { result in
            switch result {
            case .success(let response):
                self.allUsersResponse = response
                guard let allUsersResponse = self.allUsersResponse else { return }
                self.presenter?.presentAllUsers(response: allUsersResponse.body)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

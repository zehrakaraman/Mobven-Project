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
    var allGroupsResponse: AllGroups? { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    var allGroupsResponse: AllGroups?
    
    func fetchData() {
        worker.getRequestedData() { result in
            switch result {
            case .success(let response):
                self.allGroupsResponse = response
                guard let allGroupsResponse = self.allGroupsResponse else { return }
                self.presenter?.presentAllGroups(response: Home.Case.Response(allGroupsResponse: allGroupsResponse))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
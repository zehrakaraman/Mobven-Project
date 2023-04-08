//
//  HomeWorker.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchAllGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> Void))
    func fetchAllUsers(completion: @escaping((Result<AllUsersResponse, RequestError>) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func fetchAllGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: AllGroupsEndpoint.getAllGroups, responseModel: AllGroupsResponse.self, completion: completion)
    }
    
    func fetchAllUsers(completion: @escaping((Result<AllUsersResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: AllUsersEndpoint.getAllUsers, responseModel: AllUsersResponse.self, completion: completion)
    }
}

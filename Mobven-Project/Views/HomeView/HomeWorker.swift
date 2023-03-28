//
//  HomeWorker.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchAllGroups(token: String, completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> Void))
    func fetchAllUsers(token: String, completion: @escaping((Result<AllUsersResponse, RequestError>) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func fetchAllGroups(token: String, completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: AllGroupsEndpoint.getAllGroups(token: token), responseModel: AllGroupsResponse.self, completion: completion)
    }
    
    func fetchAllUsers(token: String, completion: @escaping((Result<AllUsersResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: AllUsersEndpoint.getAllUsers(token: token), responseModel: AllUsersResponse.self, completion: completion)
    }
}

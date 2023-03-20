//
//  HomeWorker.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func getRequestedData(token: String, completion: @escaping ((Result<AllGroups, RequestError>) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func getRequestedData(token: String, completion: @escaping ((Result<AllGroups, RequestError>) -> Void)) {
        sendRequest(endpoint: AllGroupsEndpoint.getAllGroups(token: token), responseModel: AllGroups.self, completion: completion)
    }
}

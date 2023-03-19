//
//  HomeWorker.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func getRequestedData(completion: @escaping ((Result<AllGroups, RequestError>) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func getRequestedData(completion: @escaping ((Result<AllGroups, RequestError>) -> Void)) {
        sendRequest(endpoint: AllGroupsEndpoint.getAllGroups, responseModel: AllGroups.self, completion: completion)
    }
}

//
//  AllGroupsEndpoint.swift
//  Mobven-Project
//
//  Created by Zehra on 16.03.2023.
//

import Foundation

public enum AllGroupsEndpoint {
    case getAllGroups
}

extension AllGroupsEndpoint: Endpoint {
    public var method: RequestMethod {
        switch self {
        case .getAllGroups:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getAllGroups:
            return "/api/v1/groups"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .getAllGroups:
            return nil
        }
    }
    
    public var body: [String : String]? {
        return nil
    }
    
    public var header: [String : String]? {
        guard let tokenData = KeyChainManager.shared.loadData(
            service: KeyChainConstants.accessTokenService,
            account: KeyChainConstants.account) else { return nil }
        guard let accessToken = String(data: tokenData, encoding: .utf8) else { return nil }
        
        switch self {
        case .getAllGroups:
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }
}

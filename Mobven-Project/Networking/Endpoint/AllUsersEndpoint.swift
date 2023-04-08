//
//  AllUsersEndpoint.swift
//  Mobven-Project
//
//  Created by Zehra on 24.03.2023.
//

import Foundation

public enum AllUsersEndpoint {
    case getAllUsers
}

extension AllUsersEndpoint: Endpoint {
    public var method: RequestMethod {
        switch self {
        case .getAllUsers:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getAllUsers:
            return "/api/v1/auth"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .getAllUsers:
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
        case .getAllUsers:
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }
}

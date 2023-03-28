//
//  AllUsersEndpoint.swift
//  Mobven-Project
//
//  Created by Zehra on 24.03.2023.
//

import Foundation

public enum AllUsersEndpoint {
    case getAllUsers(token: String)
}

extension AllUsersEndpoint: Endpoint {
    public var method: RequestMethod {
        switch self {
        case .getAllUsers(_):
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getAllUsers(_):
            return "/api/v1/auth"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .getAllUsers(_):
            return nil
        }
    }
    
    public var body: [String : String]? {
        return nil
    }
    
    public var header: [String : String]? {
        switch self {
        case .getAllUsers(let token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
}

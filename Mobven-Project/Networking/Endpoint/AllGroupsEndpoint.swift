//
//  AllGroupsEndpoint.swift
//  Mobven-Project
//
//  Created by Zehra on 16.03.2023.
//

import Foundation

public enum AllGroupsEndpoint {
    case getAllGroups(token: String)
}

extension AllGroupsEndpoint: Endpoint {
    public var method: RequestMethod {
        switch self {
        case .getAllGroups(_):
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getAllGroups(_):
            return "/api/v1/groups"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .getAllGroups(_):
            return nil
        }
    }
    
    public var body: [String : String]? {
        return nil
    }
    
    public var header: [String : String]? {
        switch self {
        case .getAllGroups(let token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
}

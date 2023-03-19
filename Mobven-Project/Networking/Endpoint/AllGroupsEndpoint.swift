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
        
        switch self {
        case .getAllGroups:
            return ["Authorization": "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWJqZWN0IjoiY29tbXVuZS1iZSIsImRldmljZUlEIjoiQ0E0RURFOTYtMUM3MS00RjFDLUI2RjAtRkM4RDhGM0QyRjU2IiwiZXhwaXJhdGlvbiI6MTY4NzkwMTU3OC45NTEzMzl9.FDuMG-LNjfgrkE45ZgMuhLnxyh6M5mI40WtJ8vrBGO48AlG4jBfk6pnyCTSjhZ34G3y8Qs4d2s1N8t6K_uWChA"]
        }
    }
}

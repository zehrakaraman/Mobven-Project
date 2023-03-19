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
            return ["Authorization": "Bearer " + "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmF0aW9uIjoxNjg3ODY2NTIzLjY4NDM4Nywic3ViamVjdCI6ImNvbW11bmUtYmUiLCJkZXZpY2VJRCI6IkNBNEVERTk2LTFDNzEtNEYxQy1CNkYwLUZDOEQ4RjNEMkY1NiJ9.PVNzwoZHOjHYFhZ2merA8Zl-bv11Fc3xeRdVf4GZiZYpU847Swbn90wFP2x6z5JB-if567bgA6nr8wJ6cyKrhw"]
        }
    }
}

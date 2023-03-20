//
//  LoginEndpoint.swift
//  Mobven-Project
//
//  Created by Zehra on 20.03.2023.
//

import Foundation

public enum LoginEndpoint {
    case login(username: String, password: String)
}

extension LoginEndpoint: Endpoint {
    public var method: RequestMethod {
        switch self {
        case .login(_, _):
            return .post
        }
    }
    
    public var path: String {
        switch self {
        case .login(_, _):
            return "/api/v1/auth/login"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .login(_, _):
            return nil
        }
    }
    
    public var body: [String : String]? {
        return nil
    }
    
    public var header: [String : String]? {
        switch self {
        case .login(let username, let password):
            let authString = String(format: "%@:%@", username, password)
            let authData = (authString.data(using: .utf8)!.base64EncodedString())
            return ["Authorization": "Basic \(authData)",
                    "X-Device-Id": "134ACE7F-12B1-4CB0-8640-CCA1E277A42D--",
                    "X-Platform": "OSX",
                    "X-Device-Name": "iPhone 12 Mini",
                    "X-Push-Notification-Token": "a3a008557dffa51bf5b7f24deb4dbc1196397a22e72b0980f0b3a9cb219204ee"
            ]
        }
    }
}

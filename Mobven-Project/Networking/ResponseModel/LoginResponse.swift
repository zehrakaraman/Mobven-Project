//
//  LoginResponse.swift
//  Mobven-Project
//
//  Created by Zehra on 20.03.2023.
//

import Foundation

public struct LoginResponse: Codable {
    public let reason: String
    public let error: Bool
    public let body: Authorized
}

public struct Authorized: Codable {
    public let id: String
    public let fullName: String
    public let email: String
    public let profilePhoto: String
    public let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "nameSurname"
        case email
        case profilePhoto
        case accessToken
    }
}

//
//  AllUsersResponse.swift
//  Mobven-Project
//
//  Created by Zehra on 24.03.2023.
//

import Foundation

public struct AllUsersResponse: Codable {
    public let reason: String
    public let error: Bool
    public let body: [User]
}

public struct User: Codable {
    public let id: String
    public let fullName: String
    public let email: String
    public let phoneNumber: String?
    public let title: String
    public let profilePhoto: String?
    public let createdAt: String
    public let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "nameSurname"
        case email
        case phoneNumber
        case title
        case profilePhoto
        case createdAt
        case updatedAt
    }
}

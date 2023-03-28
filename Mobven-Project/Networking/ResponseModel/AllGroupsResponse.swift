//
//  GetResponse.swift
//  Mobven-Project
//
//  Created by Zehra on 16.03.2023.
//

import Foundation

public struct AllGroupsResponse: Codable{
    
    public let reason: String
    public let error: Bool
    public let body: AllGroupsBody

    public struct AllGroupsBody: Codable{
        public let groups: [Group]
    }

    public struct Group: Codable {
        public let id: String
        public let name: String
        public let users: [User]?
        public let groupPhoto: String?
        public let lastMessage: Message?
        public let createdAt: String
        public let deletedAt: String?
    }
    
    public struct User: Codable {
        public let id: String
        public let fullName: String
        public let email: String
        public let title: String
        public let profilePhoto: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case fullName = "nameSurname"
            case email
            case title
            case profilePhoto
        }
    }

    public struct Message: Codable {
        public let from: User
        public let message: String
        public let to: To
    }
    
    public struct To: Codable {
        public let id: String
        public let name: String
        public let groupPhoto: String?
        public let createdAt: String
        public let deletedAt: String?
    }

    
}

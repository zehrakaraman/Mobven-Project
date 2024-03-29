//
//  HomeModels.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Home {
    
    enum Case {
        
        struct Request {
            
        }
        
        struct Response {
//            var allGroupsResponse: AllGroupsResponse
//            var allUsersResponse: AllUsersResponse
        }
        
        struct ViewModel {
//            let allGroupsListViewModel: [Home.Case.ViewModel.GroupsModel]
            
            struct GroupsModel {
                let name: String
                let users: [User]?
                let groupPhoto: String?
                let lastMessage: Message?
                let createdAt: String
                let deletedAt: String?
            }
            
            struct Message {
                let from: String
                let message: String
            }

            struct User {
                public let fullName: String
                public let email: String
                public let title: String
                public let profilePhoto: String?
                public let phoneNumber: String?
                public let createdAt: String?
                public let updatedAt: String?
            }
        }
        
    }
}
// swiftlint:enable nesting

//
//  HomePresenter.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentAllGroups(response: [AllGroupsResponse.Group])
    func presentAllUsers(response: [User])
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func presentAllGroups(response: [AllGroupsResponse.Group]) {
        var allGroups: [Home.Case.ViewModel.GroupsModel] = []
    
        response.forEach { group in
            let users = group.users?.map({ user in
                return Home.Case.ViewModel.User(
                    fullName: user.fullName,
                    email: user.email,
                    title: user.title,
                    profilePhoto: user.profilePhoto)
            })
            
            let lastMessage = Home.Case.ViewModel.Message(
                from: group.lastMessage?.from.fullName ?? "No message",
                message: group.lastMessage?.message ?? "")
            
            allGroups.append(Home.Case.ViewModel.GroupsModel(
                name: group.name,
                users: users,
                groupPhoto: group.groupPhoto,
                lastMessage: lastMessage,
                createdAt: group.createdAt,
                deletedAt: group.deletedAt))
        }
        
        viewController?.displayAllGroups(viewModel: allGroups)
    }
    
    func presentAllUsers(response: [User]) {
        var allUsers: [Home.Case.ViewModel.User] = []
        
        response.forEach { user in
            allUsers.append(Home.Case.ViewModel.User(
                fullName: user.fullName,
                email: user.email,
                title: user.title,
                profilePhoto: user.profilePhoto))
        }
        
        viewController?.displayAllUsers(viewModel: allUsers)
    }
}

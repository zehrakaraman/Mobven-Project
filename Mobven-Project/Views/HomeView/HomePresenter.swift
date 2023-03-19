//
//  HomePresenter.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentAllGroups(response: Home.Case.Response)
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func presentAllGroups(response: Home.Case.Response) {
        var allGroups: [Home.Case.ViewModel.GroupsModel] = []
        
        response.allGroupsResponse.body.groups.forEach { group in
            let users = group.users?.map({ user in
                return Home.Case.ViewModel.User(
                    nameSurname: user.nameSurname,
                    email: user.email,
                    title: user.title,
                    profilePhoto: user.profilePhoto)
            })
            
            let lastMessage = Home.Case.ViewModel.Message(
                from: group.lastMessage?.from.nameSurname ?? "No message",
                message: group.lastMessage?.message ?? "")
            
            allGroups.append(Home.Case.ViewModel.GroupsModel(
                name: group.name,
                users: users,
                groupPhoto: group.groupPhoto,
                lastMessage: lastMessage,
                createdAt: group.createdAt,
                deletedAt: group.deletedAt))
        }
        
        viewController?.displayAllGroups(viewModel: Home.Case.ViewModel(allGroupsListViewModel: allGroups))
    }
}

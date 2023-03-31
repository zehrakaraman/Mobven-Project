//
//  ChatInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 30.03.2023.
//

import Foundation

protocol ChatBusinessLogic: AnyObject {
    
}

protocol ChatDataStore: AnyObject {
    var authorizedUser: Authorized? { get set }
    var user: Home.Case.ViewModel.User? { get set }
}

final class ChatInteractor: ChatBusinessLogic, ChatDataStore {
    var presenter: ChatPresentationLogic?
    var worker: ChatWorkingLogic = ChatWorker()
    var authorizedUser: Authorized?
    var user: Home.Case.ViewModel.User?
}

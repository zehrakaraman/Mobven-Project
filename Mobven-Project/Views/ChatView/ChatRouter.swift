//
//  ChatRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 30.03.2023.
//

import Foundation

protocol ChatRoutingLogic: AnyObject {
    
}

protocol ChatDataPassing: AnyObject {
    var dataStore: ChatDataStore? { get }
}

final class ChatRouter: ChatRoutingLogic, ChatDataPassing {
    
    weak var viewController: ChatViewController?
    var dataStore: ChatDataStore?
    
}

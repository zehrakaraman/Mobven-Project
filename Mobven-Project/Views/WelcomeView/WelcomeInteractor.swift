//
//  WelcomeInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import Foundation

protocol WelcomeBusinessLogic: AnyObject {
    
}

protocol WelcomeDataStore: AnyObject {
    
}

final class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
    
    var presenter: WelcomePresentationLogic?
    var worker: WelcomeWorkingLogic = WelcomeWorker()
    
}

//
//  RegisterInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import Foundation

protocol RegisterBusinessLogic: AnyObject {
    
}

protocol RegisterDataStore: AnyObject {
    
}

final class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorkingLogic = RegisterWorker()
    
}
